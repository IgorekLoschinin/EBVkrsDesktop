#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

"""
	Backend module for application core functionality.

	This module provides the main backend controller that manages data models,
	signal handling, and processing operations. It serves as the bridge between
	the UI and business logic components.

	Classes:
		Backend: Main backend controller class that manages application state
		and operations.
"""

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
	"""
	Main backend controller class for the application.

	This class manages:
	- Data models (Phenotype, Individual, EBV, Progress Bar, and Settings)
	- Signal handling between UI and backend
	- Processing operations
	- Workspace directory management

	Signals:
		ebvModelSig: Signal emitted when EBV model changes
		indModelSig: Signal emitted when Individual model changes
		phenModelSig: Signal emitted when Phenotype model changes
		progBarSig: Signal emitted when Progress Bar model changes
		settingsModelSig: Signal emitted when Settings model changes

	Properties:
		phen_model (PhenoModel): Access to phenotype model
		ind_model (IndModel): Access to individual model
		ebv_model (EbvModel): Access to EBV (Estimated Breeding Value) model
		progbar_model (ProgBarModel): Access to progress bar model
		settings_model (SettingsModel): Access to settings model
	"""

	ebvModelSig = Signal()
	indModelSig = Signal()
	phenModelSig = Signal()
	progBarSig = Signal()
	settingsModelSig = Signal()

	def __init__(self) -> None:
		"""Initialize the Backend controller."""
		QObject.__init__(self)

		self._thread = None
		self._worker_md = None

		# Initialize data models
		self._phen_model = PhenoModel()
		self._ebv_model = EbvModel()
		self._ind_model = IndModel()
		self._prog_bar_model = ProgBarModel()
		self._settings_model = SettingsModel()

	@Property(PhenoModel, notify=phenModelSig)
	def phen_model(self) -> PhenoModel:
		""" Get the phenotype model.

		:return PhenoModel: The phenotype data model.
		"""
		return self._phen_model

	@Property(IndModel, notify=indModelSig)
	def ind_model(self) -> IndModel:
		""" Get the individual model.

		:return	IndModel: The individual data model.
		"""
		return self._ind_model

	@Property(EbvModel, notify=ebvModelSig)
	def ebv_model(self) -> EbvModel:
		""" Get the EBV (Estimated Breeding Value) model.

		:return EbvModel: The EBV data model.
		"""
		return self._ebv_model

	@Property(ProgBarModel, notify=progBarSig)
	def progbar_model(self) -> ProgBarModel:
		"""Get the progress bar model.

		:return	ProgBarModel: The progress bar model.
		"""
		return self._prog_bar_model

	@Property(SettingsModel, notify=settingsModelSig)
	def settings_model(self) -> SettingsModel:
		""" Get the settings model.

		:return SettingsModel: The settings model.
		"""
		return self._settings_model

	@property
	def common_namespace(self) -> Path:
		""" Get the application's workspace directory path.

		:return: Return absolute path to the workspace directory.
		"""
		return Path().cwd().joinpath(WORKSPACE_DIR)

	@Slot(dict)
	def run(self, data: dict | None) -> None:
		""" Execute the main processing operation with the provided data.

		:param data: Dictionary containing input data for processing. If None,
			logs an error and returns.

		:raise Exception: If processing fails, exception is caught and logged.
		"""

		if data is None:
			self.error("Data is not None!")
			return None

		# Ensure workspace directory exists
		if not (self.common_namespace.is_dir() and
				self.common_namespace.exists()):
			self.common_namespace.mkdir()

		try:
			# Initialize and run model handler
			self._worker_md = ModelHandler(
				data=data,
				output_dir=self.common_namespace
			)
			self.progbar_model.finished_code = -1  # Code for 'in process' message

			self._worker_md.handle()
			self._worker_md.exitCode.connect(self._exec_prog)

			# Activate progress bar in UI
			self.progbar_model.enable_prg_win = True

		except Exception as e:
			self.exception(e)

	@Slot()
	def ok(self) -> None:
		""" Signal handler for process completion confirmation in progress bar.
		"""
		self.progbar_model.enable_prg_win = False
		self.progbar_model.finished = False

	@Slot()
	def stop(self) -> None:
		""" Signal handler to cancel or stop the process in progress bar. """
		if self._worker_md is not None:
			self._worker_md.stop_processing()
		self.progbar_model.enable_prg_win = False

	def _exec_prog(self, code: int) -> None:
		""" Handle process completion based on exit code.

		:param code: Process exit code (0 for success, non-zero for failure).
		"""
		self.progbar_model.finished_code = code

		if code == 0:
			self.progbar_model.finished = True
		else:
			self.progbar_model.finished = False
