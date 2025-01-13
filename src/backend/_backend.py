#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2023-2024 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('Backend',)

from pathlib import Path

from PySide6.QtCore import (
	QObject,
	Slot,
	Signal,
	Property
)

from .libkrs.core.settings import (
	WORKSPACE_DIR,
	CMD_FEATURE
)
from .libkrs.est.varmodel import (
	FEATURE_NAME_SCS,
	FEATURE_NAME_MILK,
	FEATURE_NAME_REPROD,
	FEATURE_NAME_CONFORM
)
from .libkrs.utils import (
	logger,
	from_json,
	to_json
)
from .models.modelhandler import ModelHandler
from .models import SettingsModel


@logger(name="Backend")
class Backend(QObject):

	getfieldsTable = Signal(dict)
	enablePrgW = Signal(bool)
	finishedCodeSig = Signal(int)
	finishedSig = Signal(int)

	uploadVar = Signal(dict)
	settingsModelSig = Signal()

	def __init__(self) -> None:
		QObject.__init__(self)

		self._thread = None
		self._worker_md = None
		self._settings_model = SettingsModel()

		self._finished: bool = False
		self._finished_code: int | None = None
		self._enable_prg_win: bool = False

	@property
	def common_namespace(self) -> Path:
		"""Returns the absolute path to the application's workspace directory.

		This method constructs a path by using the current working directory
		(cwd) and appending the `WORKSPACE_DIR` subdirectory.

		:return: Path: A `Path` object representing the absolute path to the
			workspace directory.
		"""

		return Path().cwd().joinpath(WORKSPACE_DIR)

	@Property(list, constant=True)
	def list_feature(self) -> list[str]:
		return CMD_FEATURE

	@Property(dict, notify=getfieldsTable)
	def get_fields_table(self) -> dict[str, list[str]]:
		return dict(zip(
			CMD_FEATURE,
			[
				FEATURE_NAME_MILK,
				FEATURE_NAME_CONFORM,
				FEATURE_NAME_REPROD,
				FEATURE_NAME_SCS
			]
		))

	@Property(bool, notify=enablePrgW)
	def enable_prg_win(self) -> bool:
		return self._enable_prg_win

	@enable_prg_win.setter
	def enable_prg_win(self, value: bool) -> None:
		if self._enable_prg_win != value:
			self._enable_prg_win = value

			self.enablePrgW.emit(value)

	@Property(int, notify=finishedCodeSig)
	def finished_code(self) -> int | None:
		return self._finished_code

	@finished_code.setter
	def finished_code(self, value: int) -> None:
		if self._finished_code != value:
			self._finished_code = value

			self.finishedCodeSig.emit(value)

	@Property(int, notify=finishedSig)
	def finished(self) -> int | None:
		return self._finished

	@finished.setter
	def finished(self, value: bool) -> None:
		if self._finished != value:
			self._finished = value

			self.finishedSig.emit(value)

	@Slot(dict)
	def run(self, data: dict | None) -> None:

		if data is None:
			self.error("Data is not None!")
			return None

		self.__make_dir_workspace()

		try:
			self._worker_md = ModelHandler(
				data=data,
				output_dir=self.common_namespace
			)
			self.finished_code = -1

			self._worker_md.handle()
			self._worker_md.exitCode.connect(self._exec_prog)

			self.enable_prg_win = True

		except Exception as e:
			self.exception(e)

	@Slot()
	def stop(self) -> None:
		self._worker_md.stop_processing()
		self.enable_prg_win = False

	@Slot()
	def ok(self) -> None:
		self.enable_prg_win = False

	def _exec_prog(self, code: int) -> None:
		""" Method that fires when all event loops in a thread have completed -
		the program has completed

		:param code:
		:return:
		"""
		self.finished_code = code
		self.finished = True

	def __make_dir_workspace(self) -> None:
		""" Creates a working directory - a directory of the general
		environment if the program is launched for the first time """
		if not (self.common_namespace.is_dir() and
				self.common_namespace.exists()):
			self.common_namespace.mkdir()

	@Slot(dict, str)
	def save_variance_conf(self, data: dict[str, dict], path_file: str) -> None:
		to_json(data, path_file)

	@Slot(str)
	def load_variance_conf(self, path_file: str) -> None:
		data = from_json(path_file)

		self.uploadVar.emit(data)

	@Slot(dict)
	def print_qml(self, data: dict) -> None:
		print(data)

	@Slot(dict)
	def set_settings(self, data: dict) -> None:
		self._settings_model.settings = data

		self.settingsModelSig.emit()

	@Property(dict, notify=settingsModelSig)
	def get_settings(self) -> dict:
		return self._settings_model.settings
