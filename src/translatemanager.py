#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2023-2024 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"

import os
from pathlib import Path

from PySide6.QtCore import (
	QCoreApplication,
	QTranslator,
	QObject,
	Property,
	Signal,
	Slot,
)

from src.libkrs.utils import (
	logger,
	CheckMixin
)


@logger(name="TranslationManager")
class TranslationManager(QObject, CheckMixin):

	langChanged: Signal = Signal()
	langList: Signal = Signal(list)

	def __init__(self, engine) -> None:
		QObject.__init__(self)

		self._translator = None
		self._engine = engine

		self._lang_list = {
			"English": "languages/lang_en.qm",
			"Russian": "languages/lang_ru.qm"
		}

	@Property(list, notify=langList)
	def languages(self) -> list[str]:
		return list(self._lang_list.keys())

	@Slot(str)
	def load_language(self, lang_name: str) -> None:

		abs_path_lg = os.path.join(
			Path(__file__).parent, self._lang_list[lang_name]
		)

		if not self.is_file(abs_path_lg):
			self.error(f"File language {abs_path_lg} is not find.")
			return None

		if self._translator is not None:
			QCoreApplication.instance().removeTranslator(self._translator)

		self._translator = QTranslator()
		if self._translator.load(abs_path_lg):

			if QCoreApplication.instance().installTranslator(self._translator):
				self._engine.retranslate()

			self.langChanged.emit()
