#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2023-2024 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"

from pathlib import Path

from PySide6.QtCore import QObject, Slot, Signal

from .models.modelhandler import ModelHandler
from src.libkrs.core.settings import WORKSPACE_DIR


class Backend(QObject):

	runMesg = Signal(dict)
	runSig = Signal(dict)
	stopSig = Signal()

	def __init__(self) -> None:
		QObject.__init__(self)

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
			model_handler = ModelHandler(
				data=data,
				output_dir=self.common_namespace
			)
			model_handler.handle()

		except Exception as e:
			#logger.exception()
			print(e)

		print(data.get("id"))
		self.runMesg.emit("hgjhghgjgjh")

	@Slot(dict)
	def stop(self) -> None:
		...

	def __make_dir_workspace(self) -> None:
		""" Creates a working directory - a directory of the general
		environment if the program is launched for the first time """
		if not (self.common_namespace.is_dir() and
				self.common_namespace.exists()):
			self.common_namespace.mkdir()
