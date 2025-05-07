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


# -- Description of the configuration settings for processing the EBV --
class RequestEbv(BaseModel):
	id: str
	estmethod: str
	feature: str | list[str]
	variance: Any
	varmethod: str
	parallel: bool
	numthread: None | str
	utilsf90: None | str

	@model_validator(mode="before")
	def validate_and_transform(cls, values: dict[str, Any]):

		if values.get("auto"):
			return values

		feature = values.get("feature")
		_variance = None

		match values.get('varmethod'):
			case "all":
				_variance = values.get("variance").default_model

			case "conf":
				_variance = values.get("variance").get_data

		# Map feature -> model type
		_var_model = dict(
			zip(
				CMD_FEATURE,
				(VarConfMilk, VarConfConform, VarConfReprod, VarConfSomatCell),
			)
		)

		# Determine the expected type based on feature
		expected_model = _var_model.get(feature)
		if not expected_model:
			raise ValueError(f"Invalid feature: {feature}")

		# Convert variance to the expected type if possible
		try:
			values["variance"] = expected_model(**_variance)

			return values

		except Exception as e:
			raise TypeError(
				f"Cannot convert variance to {expected_model.__name__}: {e}"
			)
