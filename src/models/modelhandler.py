#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2023-2024 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"

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
from ..libkrs.utils.logger import logger


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

		self.model: IModel | None = None

		# self._is_running = True

	@Slot()
	def handle(self) -> None:

		try:
			match self._data.get("id"):
				case "procpheno":
					self.model = PhenoModel(
						req_data=self._data,
						output_dir=self._output_dir
					)

				case "procsnp":
					self.model = SnpModel(
						req_data=self._data,
						output_dir=self._output_dir
					)

				case "ebv":
					self.model = EbvModel(
						req_data=self._data,
						output_dir=self._output_dir
					)

				case "index":
					self.model = IndModel(
						req_data=self._data,
						output_dir=self._output_dir
					)

				case None:
					return None

			self.model.processing()
			self.exitCode.emit(0)

		except Exception as e:
			self.exception(e)
			self.exitCode.emit(1)
			return None

	@Slot()
	def stop(self) -> None:
		# self._is_running = False
		self.exitCode.emit(1)
