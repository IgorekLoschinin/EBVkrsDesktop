#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2023-2024 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"

from pathlib import Path
from pydantic_core import ValidationError

from .imodel import IModel
from ..schemas import RequestSnp

from ..libkrs.processing import SnpProcessing
from ..libkrs.utils import logger


@logger(name="SnpModel")
class SnpModel(IModel):
	"""  """

	def __init__(
			self,
			req_data: dict | None = None,
			output_dir: str | Path | None = None
	) -> None:

		self._out_d = output_dir
		self._settings: RequestSnp | None = None

		try:
			if req_data is not None:
				self._settings = RequestSnp.model_validate(req_data)

		except (ValidationError, Exception) as err:
			raise err

	def processing(self) -> None:
		""" Processing a request for SNP data processing. """

		snp_args = {}

		if self._settings.snp.checked:
			snp_args.update({
				"snp": self._settings.snp.refsnpfile,
				"sample": self._settings.snp.samplefile,
				"update": self._settings.snp.updatefile,
				"out": self._out_d
			})

		if self._settings.fr.checked:
			snp_args.update({
				"dir_fr": self._settings.fr.dirfilefr,
				"cr": float(self._settings.fr.callrate),
				"out": self._out_d
			})

			if self._settings.fr.savecrfile.checked:
				snp_args.update({
					"file_cr": self._settings.fr.savecrfile.filename
				})

			if self._settings.fr.addsuff.checked:
				if self._settings.fr.addsuff.add:
					snp_args.update({
						"add_sex": self._settings.fr.addsuff.checked
					})

				if self._settings.fr.addsuff.fromfile is not None:
					snp_args.update({
						"file_sex": self._settings.fr.addsuff.fromfile
					})

		snp_prc = SnpProcessing(**snp_args)
		snp_prc.run_snp()
