#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('ModelHandler', )

from multiprocessing import Process
from pathlib import Path

from PySide6.QtCore import (
	QObject,
	Slot,
	Signal,
	QTimer
)

from . import (
	PhenoModel,
	SnpModel,
	EbvModel,
	IndModel
)
from .imodel import IModel
from ..libkrs.utils import logger


@logger(name="ModelHandler")
class ModelHandler(QObject):
	""" The ModelHandler class is designed to control data processing using
	various models (PhenoModel, SnpModel, EbvModel, IndModel). It uses
	multiprocessing to run processing in a separate process and Qt's signal
	and slot mechanism for process control and error handling. The class also
	supports the ability to stop a process and track its state using a timer.

	:param data: Input data for configuring the model.
	:param output_dir: Directory for saving output results.
	"""

	exitCode = Signal(int)

	def __init__(
			self,
			data: dict | None = None,
			output_dir: str | Path | None = None
	) -> None:
		QObject.__init__(self)

		self._data = data
		self._output_dir = output_dir

		self._model: IModel | None = None

		self._obj_process = None
		self._timer = None

	@Slot()
	def handle(self) -> None:
		""" The main method to start data processing. Depending on the id
		value in the input data (self._data), selects the appropriate model
		and starts the processing.

		Operating logic:
		Checks the value of self._data.get("id") to select a model:

		"procpheno": Creates a PhenoModel object.
		"procsnp": Creates a SnpModel object.
		"ebv": Creates an EbvModel object.
		"index": Creates an IndModel object.

		If id is None, the method terminates execution.
		Starts a processing process using multiprocessing.Process.
		Starts a timer (QTimer) to monitor the state of the process.
		"""

		try:
			match self._data.get("id"):
				case "procpheno":
					self._model = PhenoModel(
						req_data=self._data,
						output_dir=self._output_dir
					)

				case "procsnp":
					self._model = SnpModel(
						req_data=self._data,
						output_dir=self._output_dir
					)

				case "ebv":
					self._model = EbvModel(
						req_data=self._data,
						output_dir=self._output_dir
					)

				case "index":
					self._model = IndModel(
						req_data=self._data,
						output_dir=self._output_dir
					)

				case None:
					return None

			self._obj_process = Process(target=self._model.processing)
			self._obj_process.start()

			self._timer = QTimer(self)
			self._timer.timeout.connect(self.handle_timeout)
			self._timer.setInterval(1000)
			self._timer.start()

		except Exception as e:
			self.exception(e)
			self.exitCode.emit(1)
			return None

	@Slot()
	def stop_processing(self) -> None:
		""" Method for stopping the processing process. If the process is
		running and active, it is terminated forcibly.

		Checks if the process object (self._obj_process) exists and is active.
		If the process is active, it is terminated using the kill() method.
		"""
		if self._obj_process is not None and self._obj_process.is_alive():
			self._obj_process.kill()

			return

	@Slot()
	def handle_timeout(self) -> None:
		""" Method that is called on a timer to check the status of the
		processing. """

		if not self._obj_process.is_alive():
			self.exitCode.emit(self._obj_process.exitcode)
			self._timer.stop()

			return

		# self._timer.setInterval(self._timer.interval() + 500)
