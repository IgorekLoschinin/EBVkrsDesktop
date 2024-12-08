#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2023-2024 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"

from pathlib import Path

from PySide6.QtCore import QObject, Slot, Signal, QThread

from .models.modelhandler import ModelHandler
from .libkrs.core.settings import WORKSPACE_DIR


class Backend(QObject):

	runMesg = Signal(str)
	runSig = Signal(dict)
	stopSig = Signal()

	def __init__(self) -> None:
		QObject.__init__(self)

		self._thread = None

	@property
	def common_namespace(self) -> Path:
		"""Returns the absolute path to the application's workspace directory.

		This method constructs a path by using the current working directory
		(cwd) and appending the `WORKSPACE_DIR` subdirectory.

		:return: Path: A `Path` object representing the absolute path to the
			workspace directory.
		"""

		return Path().cwd().joinpath(WORKSPACE_DIR)

	@Slot(dict)
	def run(self, data: dict | None) -> None:

		if data is None:
			# logger.error("Data is not None")
			return None

		self.__make_dir_workspace()

		try:
			# self._thread = QThread()
			# self.model_handler = ModelHandler(
			# 	data=data,
			# 	output_dir=self.common_namespace
			# )
			# # model_handler.handle()
			# self.model_handler.moveToThread(self._thread)
			#
			# # Связываем сигналы и слоты
			# self._thread.started.connect(self.model_handler.handle)  # Запуск run при старте потока
			# self.model_handler.exitCode.connect(self._exit_code)  # Сигнал завершения
			# self.model_handler.exitCode.connect(self._thread.quit)  # Остановка потока
			# self._thread.finished.connect(self.model_handler.deleteLater)  # Удаление worker
			# self._thread.finished.connect(self._thread.deleteLater)  # Удаление потока
			#
			# self._thread.start()  # Запуск потока

			...

		except Exception as e:
			#logger.exception()
			print(e)

		print(data.get("id"))
		self.runMesg.emit("hgjhghgjgjh")

	@Slot(dict)
	def stop(self) -> None:
		...

	def _exit_code(self, code: int) -> None | int:
		print(code)
		return None

	def __make_dir_workspace(self) -> None:
		""" Creates a working directory - a directory of the general
		environment if the program is launched for the first time """
		if not (self.common_namespace.is_dir() and
				self.common_namespace.exists()):
			self.common_namespace.mkdir()
