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
					...

				case "ebv":
					...

				case "index":
					...

				case None:
					return None

			self.model.processing()

		except Exception as e:
			# logger.error()
			print(e)
			self.exitCode.emit(1)
			return None

		self.exitCode.emit(0)

	# def _pheno_handler(self, data: dict | None) -> None:
	# 	mod_pheno = PhenoModel(req_data=data)

	# def _snp_handler(self, data: dict | None) -> None:
	# 	mod_snp = SnpModel(req_data=data)
	#
	# def _ebv_handler(self, data: dict | None) -> None:
	# 	mod_ebv = EbvModel(req_data=data)
	#
	# def _ind_handler(self, data: dict | None) -> None:
	# 	mod_ind = IndModel(req_data=data)
