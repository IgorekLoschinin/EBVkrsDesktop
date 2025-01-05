#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2023-2024 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"


from PySide6.QtCore import (
	QCoreApplication,
	QTranslator,
	QObject,
	Property,
	Signal,
	Slot,
)

from .libkrs.utils import (
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
			"Russian": ":/languages/lang_ru.qm",
			"English": ":/languages/lang_en.qm",
		}

	@Property(list, notify=langList)
	def languages(self) -> list[str]:
		return list(self._lang_list.keys())

	@Slot(str)
	def load_language(self, lang_name: str) -> None:

		if self._translator is not None:
			QCoreApplication.instance().removeTranslator(self._translator)

		self._translator = QTranslator()
		if self._translator.load(self._lang_list[lang_name]):

			if QCoreApplication.instance().installTranslator(self._translator):
				self._engine.retranslate()

			self.langChanged.emit()
