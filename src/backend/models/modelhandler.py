#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2023-2024 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"

import time
from multiprocessing import Process
from PySide6.QtCore import (
	QObject,
	Slot,
	Signal
)

from pathlib import Path

from .imodel import IModel
from . import (
	PhenoModel,
	SnpModel,
	EbvModel,
	IndModel
)
from ..libkrs.utils import logger


@logger(name="ModelHandler")
class ModelHandler(QObject):
	"""  """

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

	@Slot()
	def handle(self) -> None:

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
			self._obj_process.join()

			self.exitCode.emit(0)

		except Exception as e:
			self.exception(e)
			self.exitCode.emit(1)
			return None

	@Slot()
	def stop_processing(self) -> None:
		if self._obj_process is not None and self._obj_process.is_alive():
			self._obj_process.kill()
			time.sleep(1)

			return
