#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
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
from .models import SettingsModel
from .handlers.modelhandler import ModelHandler


@logger(name="Backend")
class Backend(QObject):
	"""  """

	getLstFeature = Signal(list)
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

	def __make_dir_workspace(self) -> None:
		""" Creates a working directory - a directory of the general
		environment if the program is launched for the first time """
		if not (self.common_namespace.is_dir() and
				self.common_namespace.exists()):
			self.common_namespace.mkdir()

	@Property(list, notify=getLstFeature)
	def list_feature(self) -> list[str]:
		""" Возвраащет список команд - выбор названий признаков """
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

	@Slot()
	def stop(self) -> None:
		""" Сигнал для отмены или остановки процесса в прогресс баре """
		self._worker_md.stop_processing()
		self.enable_prg_win = False

	@Slot()
	def ok(self) -> None:
		""" Сигнал для подтверждения что процесс завершился в прогресс баре """
		self.enable_prg_win = False
		self.finished = False

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
			self.finished_code = -1  # Code for message 'in process...'

			self._worker_md.handle()
			self._worker_md.exitCode.connect(self._exec_prog)

			self.enable_prg_win = True  # Trigger to activate the progress bar

		except Exception as e:
			self.exception(e)

	def _exec_prog(self, code: int) -> None:
		""" Method that fires when all event loops in a thread have completed -
		the program has completed

		:param code:
		:return:
		"""
		self.finished_code = code

		if code == 0:
			self.finished = True
		else:
			self.finished = False

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
