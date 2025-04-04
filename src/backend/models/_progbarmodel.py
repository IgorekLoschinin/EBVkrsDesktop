#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('ProgBarModel', )

from PySide6.QtCore import (
	QObject,
	Signal,
	Property
)

from ..libkrs.utils import logger


@logger(name="ProgBarModel")
class ProgBarModel(QObject):
	"""  """

	enablePrgW = Signal(bool)
	finishedCodeSig = Signal(int)
	finishedSig = Signal(int)

	def __init__(self) -> None:
		QObject.__init__(self)

	@Property(bool, notify=enablePrgW)
	def enable_prg_win(self) -> bool:
		""" Возвращает логическое значение для вызова прогрессбара """
		return self._enable_prg_win

	@enable_prg_win.setter
	def enable_prg_win(self, value: bool) -> None:
		""" Флаг для управления прогресс баром. """
		if self._enable_prg_win != value:
			self._enable_prg_win = value

			self.enablePrgW.emit(value)

	@Property(int, notify=finishedCodeSig)
	def finished_code(self) -> int | None:
		""" Возвращает код завершения процесса - 0, 1, -1.

		0 - Successful, 1 - Error, -1 - processing...
		"""
		return self._finished_code

	@finished_code.setter
	def finished_code(self, value: int) -> None:
		""" Устанавливает код завершения процесса """
		if self._finished_code != value:
			self._finished_code = value

			self.finishedCodeSig.emit(value)

	@Property(int, notify=finishedSig)
	def finished(self) -> int | None:
		""" Возвращает логическое значения заверщения программы - отключает прогресс бар. """
		return self._finished

	@finished.setter
	def finished(self, value: bool) -> None:
		if self._finished != value:
			self._finished = value

			self.finishedSig.emit(value)