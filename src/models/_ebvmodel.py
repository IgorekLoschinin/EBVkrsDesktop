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
from ..schemas import RequestEbv

from ..libkrs.core import (
	Estimator,
	GEstimator
)
from ..libkrs.utils.logger import logger


@logger(name="EbvModel")
class EbvModel(IModel):
	"""  """

	def __init__(
			self,
			req_data: dict | None = None,
			output_dir: str | Path | None = None
	) -> None:

		self._out_d = output_dir
		self._settings: RequestEbv | None = None

		try:
			if req_data is not None:
				self._settings = RequestEbv.model_validate(req_data)

		except (ValidationError, Exception) as err:
			raise err

	def processing(self) -> None:
		"""  """

		match self._settings.estmethod:
			case "blup":
				ebv = Estimator(
					feature=self._settings.feature,
					vars_f=self._settings.variance.model_dump(),
					namespace=self._out_d,
					parallel=self._settings.parallel,
					workers=int(self._settings.numthread)
				)
				ebv.start()

			case "gblup":
				gebv = GEstimator(
					feature=self._settings.feature,
					vars_f=self._settings.variance.model_dump(),
					namespace=self._out_d,
					parallel=self._settings.parallel,
					workers=int(self._settings.numthread)
				)
				gebv.start()

		return None

