#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('IndModel', )

from pathlib import Path
from pydantic_core import ValidationError

from .imodel import IModel
from ..schemas import RequestInd

from ..libkrs.index import (
	IndFeature,
	ComplexIndex
)

from ..libkrs.givc import PreparationGIVC
from ..libkrs.utils import logger


@logger(name="IndModel")
class IndModel(IModel):
	"""  """

	def __init__(
			self,
			req_data: dict | None = None,
			output_dir: str | Path | None = None
	) -> None:

		self._out_d = output_dir
		self._settings: RequestInd | None = None

		try:
			if req_data is not None:
				self._settings = RequestInd.model_validate(req_data)

		except (ValidationError, Exception) as err:
			raise err

	def processing(self) -> None:
		""" Processing a request for Index data processing """

		if not self._settings.gengivc.status:
			if self._settings.index:
				ind = IndFeature(
					feature=self._settings.feature,
					dir_nspace=self._out_d,
					animal=self._settings.animal,
					division=self._settings.divdata,
					est_method=self._settings.estmethod,
					parallel=self._settings.parallel,
					workers=None if self._settings.numthread is None
					else int(self._settings.numthread),
					disabled_optim=self._settings.disableoptim
				)
				ind.run()

			if self._settings.complex_i:
				cind = ComplexIndex(
					animal=self._settings.animal,
					division=self._settings.divdata,
					method_est=self._settings.estmethod,
					dir_nspace=self._out_d
				)
				cind.run_cind()

		else:
			givc = PreparationGIVC(
				dir_files=Path(self._settings.gengivc.dirreport),
				animal=self._settings.gengivc.typereport
			)
			givc.handle()

		return None
