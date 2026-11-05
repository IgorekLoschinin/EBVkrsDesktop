#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

"""
Easy Calving (LGC) Variance Model Module.

Provides the LgcVarModel class which handles variance configuration
for easy calving traits in EBV (Estimated Breeding Value) calculations.
"""

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('LgcVarModel', )

from typing import Callable

from pydantic_core import ValidationError

from ._iftvarmodel import IFtVarModel
from ...libkrs.est.varmodel import FEATURE_NAME_LEGOTEL
from ...libkrs.est.varmodel.schemas import VarConfEaseCalving


class LgcVarModel(IFtVarModel):
	""" Model for managing variance configurations of easy calving
	(LGC) traits.

	Inherits from:
		IFtVarModel: Base interface for feature variance models.

	This class provides:
		- Storage and management of environmental (varE) and genetic (varG)
			variance components.
		- Data validation using Pydantic's LgcVarModel schema.
		- Qt Model/View interface through inherited functionality.
		- Default null-initialized model structure for SCS traits.
	"""

	def __init__(self, parent=None):
		""" Initialize the LgcVarModel with default values.

		:param parent: Parent QObject for Qt ownership, defaults to None.
		:type parent: QObject, optional
		"""
		super().__init__(parent)

	@property
	def default_model(self) -> dict:
		""" Provide the default variance structure for LGC traits.

		Creates a dictionary with all SCS traits initialized to null values:
		{'varE': None, 'varG': None}

		:return: Dictionary mapping LGC trait names to default variance
			structures.
		:rtype: dict
		"""
		return dict(zip(
			FEATURE_NAME_LEGOTEL,
			[
				{'varE': None, 'varG': None}
				for _ in range(len(FEATURE_NAME_LEGOTEL))
			]
		))

	@property
	def get_data(self) -> Callable[[], dict]:
		""" Accessor for current variance data.

		:return: Callable that returns the complete current variance data
			dictionary.
		:rtype: Callable[[], dict]
		"""
		return self._data

	def set_data(self, new_data: dict) -> None:
		""" Update model data with validation.

		Performs schema validation using LgcVarModel before updating model
		data. Emits model reset signals to notify views of changes.

		:param new_data: Dictionary containing new variance values to validate
			and set.
		:type new_data: dict
		:raises ValidationError: If input data fails schema validation.
		:raises Exception: For any other errors during the update process.
		:return: None
		"""

		try:
			if new_data is not None:
				self.beginResetModel()
				self._data.update(
					VarConfEaseCalving.model_validate(new_data).model_dump()
				)
				self._keys = list(self._data.keys())
				self.endResetModel()

		except (ValidationError, Exception) as err:
			raise err
