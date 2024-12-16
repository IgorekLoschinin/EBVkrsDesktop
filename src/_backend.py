#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2023-2024 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('Backend', )

from pathlib import Path

from PySide6.QtCore import (
	QObject,
	Slot,
	Signal,
	QThread
)

from src.models.modelhandler import ModelHandler
from src.libkrs.core.settings import WORKSPACE_DIR
from src.libkrs.utils import logger


@logger(name="Backend")
class Backend(QObject):

	runSig = Signal(str)
	stopSig = Signal()

	def __init__(self) -> None:
		QObject.__init__(self)

		self._thread = None
		self._worker_md = None

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
			self.error("Data is not None!")
			return None

		self.__make_dir_workspace()

		try:
			# self._thread = QThread()
			self._worker_md = ModelHandler(
				data=data,
				output_dir=self.common_namespace
			)
			self._worker_md.handle()

			# self._worker_md.moveToThread(self._thread)

			# # Link signals and slots
			# # Run when the thread starts
			# self._thread.started.connect(self._worker_md.handle)
			# self._worker_md.exitCode.connect(self._exit_code)
			# self._worker_md.exitCode.connect(self._thread.quit)
			# self._worker_md.exitCode.connect(self._worker_md.deleteLater)
			# self._thread.finished.connect(self._worker_md.deleteLater)
			# self._thread.finished.connect(self._thread.deleteLater)
			#
			# self._thread.start()  # Starting a thread

			# if self._thread.isRunning():
			# 	print(self._thread.exec())

		except Exception as e:
			self.exception(e)

		print(data.get("id"))
		self.runSig.emit("hgjhghgjgjh")

	@Slot()
	def stop(self) -> None:
		# self._worker_md.stop()
		# self._thread.quit()

		print("Task is stop!")

	@staticmethod
	def _exit_code(code: int) -> None | int:
		print(code)
		return None

	def __make_dir_workspace(self) -> None:
		""" Creates a working directory - a directory of the general
		environment if the program is launched for the first time """
		if not (self.common_namespace.is_dir() and
				self.common_namespace.exists()):
			self.common_namespace.mkdir()
