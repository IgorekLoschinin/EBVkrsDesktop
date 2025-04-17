#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('GeneratorCfgVar', )

from PySide6.QtCore import (
	QObject,
	Slot,
	Signal,
	Property
)

from ...libkrs.est import CreateCfgVar
from ...libkrs.utils import logger


@logger(name="GeneratorCfgVar")
class GeneratorCfgVar(QObject):
	"""
	A Qt-based configuration variable generator that provides signals and
	properties for UI integration.

	This class wraps the core CreateCfgVar functionality with Qt signals and
	slots, making it suitable for use in Qt applications with progress tracking.

	Attributes:
		finCodeSig (Signal[int]): Emitted when the operation status changes.
		createSig (Signal): Emitted when the creation process is initiated.
	"""

	__slots__ = (
		"_fin_code",
		"_from_path",
		"_creator",
	)

	finCodeSig = Signal(int)
	createSig = Signal()

	def __init__(self) -> None:
		""" Initialize the configuration generator with default values.

		Initial state:
			- fin_code: -1 (ready state)
			- from_path: None (no source path set)
			- creator: New CreateCfgVar instance
		"""
		QObject.__init__(self)

		self._fin_code: int = -1
		self._from_path: str | None = None
		self._creator = CreateCfgVar()

	@Property(int, notify=finCodeSig)
	def fin_code(self) -> int:
		""" Get the current operation status code.

		:return: Return current status code (-1: ready, 0: success, 1: failure,
			2: in progress, 3: save completed).
		"""
		return self._fin_code

	@fin_code.setter
	def fin_code(self, value: bool) -> None:
		""" Set the operation status code and emit signal if changed.

		:param value: The new status code (converted to bool then int).
		"""
		if self._fin_code != value:
			self._fin_code = value
			self.finCodeSig.emit(value)

	@Slot(str)
	def from_path(self, value: str) -> None:
		""" Set the source path for configuration generation.

		:param value: Path to the source file/directory.
		"""
		self._from_path = value

	@Slot()
	def create(self) -> None:
		""" Execute the configuration generation process.

		Progress:
			1. Sets status to 2 (in progress).
			2. Attempts creation via CreateCfgVar.
			3. Sets status to 1 if failed, 0 if succeeded.
		"""
		self.fin_code = 2

		if not self._creator.create(self._from_path):
			self.fin_code = 1
			return

		self.fin_code = 0

	@Slot(str)
	def save(self, file: str | None) -> None:
		""" Save the generated configuration to file.

		:param file: Destination file path (None for default location).

		Post-condition:
			Sets status to 3 (save completed).
		"""
		self._creator.to_file(file)
		self.fin_code = 3
