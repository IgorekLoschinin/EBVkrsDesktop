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

from .libkrs.core.settings import WORKSPACE_DIR
from .libkrs.utils import logger

from .models import (
	SettingsModel,
	EbvModel,
	IndModel,
	PhenoModel,
	ProgBarModel
)
from .handlers.modelhandler import ModelHandler


@logger(name="Backend")
class Backend(QObject):
	"""  """

	# finishedSig = Signal(int)

	ebvModelSig = Signal()
	indModelSig = Signal()
	phenModelSig = Signal()

	progBarSig = Signal()

	settingsModelSig = Signal()

	def __init__(self) -> None:
		QObject.__init__(self)

		self._thread = None
		self._worker_md = None

		# self._finished: bool = False

		self._phen_model = PhenoModel()
		self._ebv_model = EbvModel()
		self._ind_model = IndModel()

		self._prog_bar_model = ProgBarModel()

		self._settings_model = SettingsModel()

	@Property(PhenoModel, notify=phenModelSig)
	def phen_model(self) -> PhenoModel:
		return self._phen_model

	@Property(IndModel, notify=indModelSig)
	def ind_model(self) -> IndModel:
		return self._ind_model

	@Property(EbvModel, notify=ebvModelSig)
	def ebv_model(self) -> EbvModel:
		return self._ebv_model

	@Property(ProgBarModel, notify=progBarSig)
	def progbar_model(self) -> ProgBarModel:
		return self._prog_bar_model

	@Property(SettingsModel, notify=settingsModelSig)
	def settings_model(self) -> SettingsModel:
		return self._settings_model

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

		if not (self.common_namespace.is_dir() and
					self.common_namespace.exists()):
			self.common_namespace.mkdir()

		try:
			self._worker_md = ModelHandler(
				data=data,
				output_dir=self.common_namespace
			)
			self.progbar_model.finished_code = -1  # Code for message 'in process...'

			self._worker_md.handle()
			self._worker_md.exitCode.connect(self._exec_prog)

			self.progbar_model.enable_prg_win = True  # Trigger to activate the progress bar

		except Exception as e:
			self.exception(e)

	@Slot()
	def ok(self) -> None:
		""" Сигнал для подтверждения что процесс завершился в прогресс баре """
		self.progbar_model.enable_prg_win = False
		self.progbar_model.finished = False

	@Slot()
	def stop(self) -> None:
		""" Сигнал для отмены или остановки процесса в прогресс баре """
		self._worker_md.stop_processing()
		self.progbar_model.enable_prg_win = False

	def _exec_prog(self, code: int) -> None:
		""" Method that fires when all event loops in a thread have completed -
		the program has completed

		:param code:
		:return:
		"""
		self.progbar_model.finished_code = code

		if code == 0:
			self.progbar_model.finished = True
		else:
			self.progbar_model.finished = False
