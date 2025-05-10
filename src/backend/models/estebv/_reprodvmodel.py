#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

"""
Reproduction Variance Model Module.

Provides the ReprodVarModel class which handles variance configuration
for reproduction traits in EBV (Estimated Breeding Value) calculations.
"""

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('ReprodVarModel', )

from typing import Callable

from pydantic_core import ValidationError

from ._iftvarmodel import IFtVarModel
from ...libkrs.est.varmodel import FEATURE_NAME_REPROD
from ...libkrs.est.varmodel.schemas import VarConfReprod


class ReprodVarModel(IFtVarModel):
	""" Model for managing variance configurations of reproduction traits.

	Inherits from:
		IFtVarModel: Base interface for feature variance models.

	This class provides:
	- Storage and management of variance values (varE and varG) for
		reproduction traits.
	- Data validation using Pydantic's VarConfReprod schema.
	- Qt Model/View interface through inherited functionality.
	- Default model structure for reproduction traits.
	"""

	def __init__(self, parent=None):
		""" Initialize the ReprodVarModel with default values.

		:param parent: Parent QObject, defaults to None.
		:type parent: QObject, optional
		"""
		super().__init__(parent)

	@property
	def default_model(self) -> dict:
		""" Get the default variance model structure for reproduction traits.

		Creates a dictionary with all reproduction traits initialized to:
		{'varE': None, 'varG': None}

		:return: Dictionary mapping trait names to default variance structures.
		:rtype: dict
		"""
		return dict(zip(
			FEATURE_NAME_REPROD,
			[
				{'varE': None, 'varG': None}
				for _ in range(len(FEATURE_NAME_REPROD))
			]
		))

	@property
	def get_data(self) -> Callable[[], dict]:
		""" Get the current variance data for reproduction traits.

		:return: Callable that returns the current variance data dictionary.
		:rtype: Callable[[], dict]
		"""
		return self._data

	def set_data(self, new_data: dict) -> None:
		""" Set new variance data for reproduction traits with validation.

		Validates the input data against the VarConfReprod schema before
		updating. Emits model reset signals before and after updating the data.

		:param new_data: Dictionary containing new variance values.
		:type new_data: dict
		:raises ValidationError: If data fails validation against VarConfReprod
			schema.
		:raises Exception: For any other errors during validation or update.
		:return: None
		"""

		try:
			if new_data is not None:
				self.beginResetModel()
				self._data.update(
					VarConfReprod.model_validate(new_data).model_dump()
				)
				self._keys = list(self._data.keys())
				self.endResetModel()

		except (ValidationError, Exception) as err:
			raise err
