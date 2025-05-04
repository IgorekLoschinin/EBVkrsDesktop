#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('MilkVarModel',)

from typing import Callable

from PySide6.QtCore import (
	QAbstractListModel,
	QModelIndex,
	Qt,
	Slot,
	Signal,
	Property
)

from ...libkrs.est.varmodel import FEATURE_NAME_MILK


class MilkVarModel(QAbstractListModel):

	sigGetDefModel = Signal()

	def __init__(self, parent=None):
		super().__init__(parent)

		self._data = self.default_model
		self._keys = list(self._data.keys())

		# Define roles
		self.FtName = Qt.ItemDataRole.UserRole + 1
		self.VarERole = Qt.ItemDataRole.UserRole + 2
		self.VarGRole = Qt.ItemDataRole.UserRole + 3

	@property
	def get_data(self) -> Callable[[], dict]:
		return self._data

	def set_data(self, new_data: dict) -> None:
		"""

		:param new_data:
		:return:
		"""
		# валидация данных нужна что бы не запихуть молоко в экстерьер
		if new_data != self._data:
			self.beginResetModel()
			self._data = new_data.copy()
			self._keys = list(new_data.keys())
			self.endResetModel()

	@Property(dict, notify=sigGetDefModel)
	def default_model(self) -> dict:
		return dict(zip(
			FEATURE_NAME_MILK,
			[
				{'varE': None, 'varG': None}
				for _ in range(len(FEATURE_NAME_MILK))
			]
		))

	def roleNames(self) -> dict:
		return {
			self.FtName: b"ftName",
			self.VarERole: b"varE",
			self.VarGRole: b"varG"
		}

	def rowCount(self, parent: None = QModelIndex()) -> int:
		return len(self._keys)

	def data(self, index, role=Qt.ItemDataRole.DisplayRole) -> str | None:
		if not index.isValid() or not (0 <= index.row() < len(self._keys)):
			return None

		key = self._keys[index.row()]
		item = self._data[key]

		if role == self.FtName:
			return key
		elif role == self.VarERole:
			return item['varE']
		elif role == self.VarGRole:
			return item['varG']

		return None

	def setData(self, index, value, role=Qt.ItemDataRole.EditRole) -> bool:
		if not index.isValid() or not (0 <= index.row() < len(self._keys)):
			return False

		key = self._keys[index.row()]

		# Convert QString to Python str if needed
		if isinstance(value, str):
			value = value.strip() if value.strip() else None

		if role == self.VarERole:
			self._data[key]['varE'] = value
			self.dataChanged.emit(index, index, [self.VarERole])

			return True

		elif role == self.VarGRole:
			self._data[key]['varG'] = value
			self.dataChanged.emit(index, index, [self.VarGRole])

			return True

		return False

	@Slot()
	def reset(self) -> None:
		"""Очистить все данные в модели"""
		self.beginResetModel()
		self._data = self.default_model
		self._keys = list(self._data.keys())
		self.endResetModel()
