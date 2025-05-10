#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

"""
Somatic Cell Score (SCS) Variance Model Module.

Provides the ScsVarModel class which handles variance configuration
for somatic cell score traits in EBV (Estimated Breeding Value) calculations.
"""

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('ScsVarModel', )

from typing import Callable

from pydantic_core import ValidationError

from ._iftvarmodel import IFtVarModel
from ...libkrs.est.varmodel import FEATURE_NAME_SCS
from ...libkrs.est.varmodel.schemas import VarConfSomatCell


class ScsVarModel(IFtVarModel):
	""" Model for managing variance configurations of somatic cell score
	(SCS) traits.

	Inherits from:
		IFtVarModel: Base interface for feature variance models.

	This class provides:
	- Storage and management of environmental (varE) and genetic (varG)
		variance components.
	- Data validation using Pydantic's VarConfSomatCell schema.
	- Qt Model/View interface through inherited functionality.
	- Default null-initialized model structure for SCS traits.
	"""

	def __init__(self, parent=None):
		""" Initialize the ScsVarModel with default values.

		:param parent: Parent QObject for Qt ownership, defaults to None.
		:type parent: QObject, optional
		"""
		super().__init__(parent)

	@property
	def default_model(self) -> dict:
		""" Provide the default variance structure for SCS traits.

		Creates a dictionary with all SCS traits initialized to null values:
		{'varE': None, 'varG': None}

		:return: Dictionary mapping SCS trait names to default variance
			structures.
		:rtype: dict
		"""
		return dict(zip(
			FEATURE_NAME_SCS,
			[
				{'varE': None, 'varG': None}
				for _ in range(len(FEATURE_NAME_SCS))
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

		Performs schema validation using VarConfSomatCell before updating model
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
					VarConfSomatCell.model_validate(new_data).model_dump()
				)
				self._keys = list(self._data.keys())
				self.endResetModel()

		except (ValidationError, Exception) as err:
			raise err
