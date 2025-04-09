#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('SettingsModel', )


from pydantic_core import ValidationError

from ..schemas import SettingsSchema
from ..libkrs.utils import logger


@logger(name="SettingsModel")
class SettingsModel(object):
	"""  """

	def __init__(self) -> None:
		self._settings = SettingsSchema()

	@property
	def settings(self) -> dict | None:
		if self._settings is not None:
			return self._settings.model_dump()

		return None

	@settings.setter
	def settings(self, value: dict) -> None:
		try:
			self._settings = SettingsSchema.model_validate(value)

		except (ValidationError, Exception) as err:
			raise err
