#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('RequestEbv', )

from typing import Any

from pydantic import (
	BaseModel,
	model_validator
)

from ..libkrs.core.settings import CMD_FEATURE
from ..libkrs.est.varmodel.schemas import (
	VarConfMilk,
	VarConfConform,
	VarConfReprod,
	VarConfSomatCell,
)


class RequestEbv(BaseModel):
	""" Model for EBV (Estimated Breeding Value) processing request
	configuration.

	Attributes:
		id: Unique identifier for the request
		auto: Flag for automatic processing of multiple features
		estmethod: Estimation method to be used ('blup' or 'gblup')
		feature: Single feature or list of features to process
		variance: Variance configuration data
		varmethod: Method for variance handling ('all' or 'conf')
		parallel: Flag for parallel processing
		numthread: Number of threads to use (None for default)
		utilsf90: Path to Fortran utilities (optional)
	"""

	id: str
	auto: bool
	estmethod: str
	feature: str | list[str]
	variance: Any
	varmethod: str
	parallel: bool
	numthread: None | str
	utilsf90: None | str

	@model_validator(mode="before")
	def validate_and_transform(cls, values: dict[str, Any]):
		""" Validate and transform input values before model initialization.

		:param values: Raw input values to validate.
		:type values: dict[str, Any]
		:return: Validated and transformed values.
		:rtype: dict[str, Any]
		:raises ValueError: If feature is invalid.
		:raises TypeError: If variance cannot be converted to expected type.
		"""

		if values.get("auto"):

			values['variance'] = {
				ft_name: var_m.default_model
				if values['varmethod'] == 'all'
				else var_m.get_data
				for ft_name, var_m in values['variance'].items()
			}

			return values

		feature = values.get("feature")
		_variance = None

		# Select variance data based on method
		match values.get('varmethod'):
			case "all":
				_variance = values.get("variance").default_model

			case "conf":
				_variance = values.get("variance").get_data

		# Map features to their corresponding variance models
		_var_model = dict(
			zip(
				CMD_FEATURE,
				(VarConfMilk, VarConfConform, VarConfReprod, VarConfSomatCell),
			)
		)

		# Get expected model type for the feature
		expected_model = _var_model.get(feature)
		if not expected_model:
			raise ValueError(f"Invalid feature: {feature}")

		# Convert variance to the expected model type
		try:
			values["variance"] = expected_model(**_variance)

			return values

		except Exception as e:
			raise TypeError(
				f"Cannot convert variance to {expected_model.__name__}: {e}"
			)
