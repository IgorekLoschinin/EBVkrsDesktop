#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('EbvModel', )

from PySide6.QtCore import (
	QObject,
	Slot,
	Signal,
	Property
)

from ..libkrs.core.settings import CMD_FEATURE
from ..libkrs.est.varmodel import (
	FEATURE_NAME_SCS,
	FEATURE_NAME_MILK,
	FEATURE_NAME_REPROD,
	FEATURE_NAME_CONFORM
)
from ..libkrs.utils import (
	logger,
	from_json,
	to_json
)


@logger(name="EbvModel")
class EbvModel(QObject):
	"""  """

	uploadVar = Signal(dict)
	getLstFeature = Signal(list)
	getfieldsTable = Signal(dict)

	def __init__(self) -> None:
		QObject.__init__(self)

	@Property(list, notify=getLstFeature)
	def list_feature(self) -> list[str]:
		""" Возвраащет список команд - названий признаков для расчета на EBVpage """
		return CMD_FEATURE

	@Property(dict, notify=getfieldsTable)
	def get_fields_table(self) -> dict[str, list[str]]:
		""" Возвраащет структуру где ключ - название признака, значение -
		список полей для построения таблицы. EBVpage """
		return dict(zip(
			CMD_FEATURE,
			[
				FEATURE_NAME_MILK,
				FEATURE_NAME_CONFORM,
				FEATURE_NAME_REPROD,
				FEATURE_NAME_SCS
			]
		))

	@Slot(dict, str)
	def save_variance_conf(self, data: dict[str, dict], path_file: str) -> None:
		""" После заполение варианс запускаетя метод для сохранеие введенных
		данных в файл.

		:param data: Данные для сохранения.
		:param path_file: Путь к файлу для сохрания данных.
		:return: None
		"""
		to_json(data, path_file)

	@Slot(str)
	def load_variance_conf(self, path_file: str) -> None:
		""" Метод для загрузки варианс из файла.

		:param path_file: Путь к файлу конфигурации варианс.
		:return: None
		"""
		data = from_json(path_file)

		self.uploadVar.emit(data)
