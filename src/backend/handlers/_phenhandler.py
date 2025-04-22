#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

"""
Phenotype Handler Module.

Provides the PhenoHandler class for processing phenotype data requests.
"""

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('PhenoHandler', )

from pathlib import Path

from pydantic_core import ValidationError

from .ihandler import IHandler
from ..libkrs.processing.dataprocessing import DataProcessing
from ..libkrs.utils import logger
from ..schemas import RequestPheno


@logger(name="PhenoHandler")
class PhenoHandler(IHandler):
	""" Handler for processing phenotype data requests.

	This class handles the processing of phenotype data according to the
	provided configuration settings.
	"""

	def __init__(
			self,
			req_data: dict | None = None,
			output_dir: str | Path | None = None
	) -> None:
		""" Initialize the PhenoHandler instance.

		:param req_data: Input data for configuring the phenotype processing
		:type req_data: dict | None
		:param output_dir: Directory for saving output results
		:type output_dir: str | Path | None
		:raises ValidationError: If the input data fails validation
		:raises Exception: For any other errors during initialization
		"""
		self._out_d = output_dir
		self._settings: RequestPheno | None = None

		try:
			if req_data is not None:
				self._settings = RequestPheno.model_validate(req_data)

		except (ValidationError, Exception) as err:
			raise err

	def processing(self) -> None:
		""" Process the phenotype data request.

		:raises ValueError: If settings are not initialized
		:return: None
		"""
		if self._settings is None:
			raise ValueError("Settings not initialized!")

		if self._settings.preparation.checked:
			self._preparation_data()

			return

		self._selection_data()

	def _preparation_data(self) -> None:
		""" Handle data preparation processing.

		:return: None
		"""
		if self._settings.preparation.updatabd.checked:
			dp_args = {
				"phen_files": self._settings.phendata,
				"update": [
					self._settings.preparation.updatabd.pathto,
					self._settings.preparation.updatabd.pathfrom
				],
				"output_dir": self._out_d
			}

		else:
			dp_args = {
				"phen_files": self._settings.preparation.searchdaug.datafiles,
				"search_daugh": self._settings.preparation.searchdaug.filesires,
				"output_dir": self._out_d
			}

		dp = DataProcessing(**dp_args)
		dp.run()

	def _selection_data(self) -> None:
		""" Handle data selection processing.

		:return: None
		"""
		dp_args = {
			"phen_files": self._settings.phendata,
			"feature": self._settings.feature,
			"kod_xoz": self._settings.selectdata.filefarm,
			"num_lact": self._settings.numlact,
			"cal_ped": self._settings.ped,
			"cal_daugh": self._settings.daughters,
			"rm_daugh": self._settings.selectdata.removedaug,
			"accum": self._settings.accummeth,
			"add_snp": self._settings.addfilesnp,
			"output_dir": self._out_d
		}

		if self._settings.autoft and isinstance(self._settings.feature, list):
			for item_ft in self._settings.feature:
				dp_args.update({"feature": item_ft})

				dp = DataProcessing(**dp_args)
				dp.run()
			return

		dp = DataProcessing(**dp_args)
		dp.run()
