#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

"""
EBV Handler Module.

Provides the EbvHandler class for processing Estimated Breeding Value (EBV)
requests. Supports both BLUP and GBLUP estimation methods for genetic
evaluation.
"""

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
	""" Handler for Estimated Breeding Value (EBV) calculation requests.

	Processes EBV requests using either BLUP (Best Linear Unbiased Prediction)
	or GBLUP (Genomic BLUP) estimation methods.
	"""

	def __init__(
			self,
			req_data: dict | None = None,
			output_dir: str | Path | None = None
	) -> None:
		""" Initialize the EBV handler with request data and output directory.

		:param req_data: Dictionary containing EBV calculation configuration.
		:type req_data: dict | None
		:param output_dir: Directory path for storing calculation results.
		:type output_dir: str | Path | None
		:raises ValidationError: If input data fails schema validation.
		:raises Exception: For any other initialization errors.
		"""

		self._out_d = output_dir
		self._settings: RequestEbv | None = None

		try:
			if req_data is not None:
				self._settings = RequestEbv.model_validate(req_data)

		except (ValidationError, Exception) as err:
			raise err

	def processing(self) -> None:
		""" Process EBV calculation based on configured settings.

		Handles both single feature and multiple feature processing modes.
		For multiple features (auto=True), processes each feature sequentially.

		:raises ValueError: If settings are not properly initialized.
		:raises TypeError: If feature/variance data types are invalid in
			auto mode.
		:return: None
		"""

		if self._settings is None:
			raise ValueError("Settings not initialized!")

		# Multiple feature processing
		if self._settings.auto:
			for item_ft in self._settings.feature:
				self._handler_est_method(
					item_ft, self._settings.variance[item_ft]
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
		""" Execute the appropriate estimation method for EBV calculation.

		:param feature: Name of the trait/feature being evaluated.
		:type feature: str
		:param variance: Dictionary containing variance components
			configuration.
		:type variance: dict[str, Any]
		:return: None
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
