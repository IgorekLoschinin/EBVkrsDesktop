#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('EbvHandler', )

from pathlib import Path
from typing import Any

from pydantic_core import ValidationError

from .ihandler import IHandler
from ..libkrs.core import (
	Estimator,
	GEstimator
)
from ..libkrs.utils import logger
from ..schemas import RequestEbv


@logger(name="EbvHandler")
class EbvHandler(IHandler):
	""" EBV handler of requests.

	This class handles EBV (Estimated Breeding Values) requests and supports
	two estimation methods: BLUP and GBLUP.

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
		self._settings: RequestEbv | None = None

		try:
			if req_data is not None:
				self._settings = RequestEbv.model_validate(req_data)

		except (ValidationError, Exception) as err:
			raise err

	def processing(self) -> None:
		""" Processes data based on the specified estimation method.

		Depending on the method, it performs one of the following:

		- If the method is "blup", the ``Estimator`` class is used.
		- If the method is "gblup", the ``GEstimator`` class is used.
		"""

		if self._settings is None:
			raise ValueError("Settings not initialized!")

		# Multiple feature processing
		if self._settings.auto:
			if not (
				isinstance(self._settings.feature, list) and
				isinstance(self._settings.variance, list)
			):
				raise TypeError(
					"Error. The fields feature and variance is not LIST."
				)

			for item_ft in self._settings.feature:
				if self._settings.varmethod == "conf":
					self._handler_est_method(
						item_ft, self._settings.variance[item_ft].get_data
					)

				else:
					self._handler_est_method(
						item_ft, self._settings.variance[item_ft].default_model
					)

			return

		# Single feature processing
		self._handler_est_method(
			self._settings.feature, self._settings.variance.model_dump()
		)

		return None

	def _handler_est_method(
			self,
			feature: str,
			variance: dict[str, Any]
	) -> None:
		"""

		:param feature:
		:param variance:
		:return:
		"""

		match self._settings.estmethod:
			case "blup":
				ebv = Estimator(
					feature=feature,
					vars_f=variance,
					namespace=self._out_d,
					parallel=self._settings.parallel,
					workers=None
					if self._settings.numthread is None
					else int(self._settings.numthread),
					utils=Path(self._settings.utilsf90)
				)
				ebv.start()
				return

			case "gblup":
				gebv = GEstimator(
					feature=feature,
					vars_f=variance,
					namespace=self._out_d,
					parallel=self._settings.parallel,
					workers=None
					if self._settings.numthread is None
					else int(self._settings.numthread),
					utils=Path(self._settings.utilsf90)
				)
				gebv.start()
				return

		return None
