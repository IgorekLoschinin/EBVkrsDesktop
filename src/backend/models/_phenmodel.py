#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('PhenoModel', )

from pathlib import Path

from pydantic_core import ValidationError

from .imodel import IModel
from ..libkrs.processing.dataprocessing import DataProcessing
from ..libkrs.utils import logger
from ..schemas import RequestPheno


@logger(name="PhenoModel")
class PhenoModel(IModel):
	""" Phenotype model for query processing phenotype data.

	This class handles requests for processing phenotype data.

	:param req_data: Input data for configuring the model.
	:param output_dir: Directory for saving output results.
	:raises ValidationError: If the input data fails validation.
	:raises Exception: For any other errors during initialization.
	"""

	def __init__(
			self,
			req_data: dict | None = None,
			output_dir: str | Path | None = None
	) -> None:

		self._out_d = output_dir
		self._settings: RequestPheno | None = None

		try:
			if req_data is not None:
				self._settings = RequestPheno.model_validate(req_data)

		except (ValidationError, Exception) as err:
			raise err

	def processing(self) -> None:
		""" Processing a request for Phenotype data processing """

		dp_args = {}

		if self._settings.preparation.checked:
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

		else:
			if self._settings.selectdata.checked:
				dp_args = {
					"phen_files": self._settings.phendata,
					"feature": self._settings.feature,
					"kod_xoz": self._settings.selectdata.filefarm,
					"num_lact": self._settings.numlact,
					"cal_ped": self._settings.ped,
					"cal_daugh": self._settings.daughters,
					"rm_daugh": self._settings.selectdata.removedaug,
					"accum": self._settings.accummeth,
					"output_dir": self._out_d
				}

			else:
				dp_args = {
					"phen_files": self._settings.phendata,
					"feature": self._settings.feature,
					"num_lact": self._settings.numlact,
					"cal_ped": self._settings.ped,
					"cal_daugh": self._settings.daughters,
					"accum": self._settings.accummeth,
					"output_dir": self._out_d
				}

			dp_args.update({'add_snp': self._settings.addfilesnp})

		dp = DataProcessing(**dp_args)
		dp.run()
