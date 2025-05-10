#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('IFtVarModel',)

from abc import abstractmethod

from PySide6.QtCore import (
	QAbstractListModel,
	QModelIndex,
	Qt,
	Slot
)


class IFtVarModel(QAbstractListModel):

	def __init__(self, parent=None):
		super().__init__(parent)

		self._data = self.default_model.copy()
		self._keys = list(self._data.keys())

		# Define roles
		self.FtName = Qt.ItemDataRole.UserRole + 1
		self.VarERole = Qt.ItemDataRole.UserRole + 2
		self.VarGRole = Qt.ItemDataRole.UserRole + 3

	@abstractmethod
	def default_model(self) -> dict:
		raise NotImplementedError

	@abstractmethod
	def get_data(self) -> None:
		raise NotImplementedError

	@abstractmethod
	def set_data(self, new_data: dict) -> None:
		raise NotImplementedError

	def roleNames(self) -> dict:
		""" Get the role names for QML integration.

		:return: Mapping of roles to their names
		:rtype: dict
		"""
		return {
			self.FtName: b"ftName",
			self.VarERole: b"varE",
			self.VarGRole: b"varG"
		}

	def rowCount(self, parent: None = QModelIndex()) -> int:
		""" Get the number of rows in the model.

		:param parent: Parent index, defaults to None
		:type parent: QModelIndex, optional
		:return: Number of items in the model
		:rtype: int
		"""
		return len(self._keys)

	def data(self, index, role=Qt.ItemDataRole.DisplayRole) -> str | None:
		""" Get data for the given index and role.

		:param index: Index of the item
		:type index: QModelIndex
		:param role: Data role, defaults to DisplayRole
		:type role: int, optional
		:return: Requested data or None if invalid
		:rtype: str | None
		"""
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
		""" Set data for the given index and role.

		:param index: Index of the item to modify.
		:type index: QModelIndex
		:param value: New value to set.
		:type value: str
		:param role: Data role, defaults to EditRole.
		:type role: int, optional
		:return: True if successful, False otherwise.
		:rtype: bool
		"""
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
		""" Reset the model to default values.

		:return: None
		"""
		self.beginResetModel()
		self._data.update(self.default_model)
		self._keys = list(self._data.keys())
		self.endResetModel()
