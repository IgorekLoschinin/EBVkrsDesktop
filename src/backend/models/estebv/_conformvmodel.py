#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

"""
Conformation Variance Model Module.

Provides the ConformVarModel class which handles variance configuration
for conformation traits in EBV calculations.
"""

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('ConformVarModel', )

from typing import Callable

from pydantic_core import ValidationError

from ._iftvarmodel import IFtVarModel
from ...libkrs.est.varmodel import FEATURE_NAME_CONFORM
from ...libkrs.est.varmodel.schemas import VarConfConform


class ConformVarModel(IFtVarModel):
	""" Model for managing variance configurations of conformation traits.

	Inherits from:
		IFtVarModel: Base interface for feature variance models.

	This class provides:
	- Storage and management of variance values (varE and varG) for
		conformation traits.
	- Data validation using Pydantic models.
	- Qt Model/View interface through inherited functionality.
	"""

	def __init__(self, parent=None):
		""" Initialize the ConformVarModel with default values.

		:param parent: Parent QObject, defaults to None
		:type parent: QObject, optional
		"""
		super().__init__(parent)

	@property
	def default_model(self) -> dict:
		""" Get the default variance model structure for conformation traits.

		:return: Dictionary with default variance values (None) for all
			conformation traits.
		:rtype: dict
		"""
		return dict(zip(
			FEATURE_NAME_CONFORM,
			[
				{'varE': None, 'varG': None}
				for _ in range(len(FEATURE_NAME_CONFORM))
			]
		))

	@property
	def get_data(self) -> Callable[[], dict]:
		""" Get the current variance data for conformation traits.

		:return: Function that returns current variance data.
		:rtype: Callable[[], dict]
		"""
		return self._data

	def set_data(self, new_data: dict) -> None:
		""" Set new variance data with validation for conformation traits.

		:param new_data: New variance data to set.
		:type new_data: dict
		:raises ValidationError: If data fails validation against
			VarConfConform schema.
		:raises Exception: For any other errors during validation.
		:return: None
		"""

		try:
			if new_data is not None:
				self.beginResetModel()
				self._data.update(
					VarConfConform.model_validate(new_data).model_dump()
				)
				self._keys = list(self._data.keys())
				self.endResetModel()

		except (ValidationError, Exception) as err:
			raise err
