#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('TranslationManager', )


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
	""" The TranslationManager class is designed to manage translations in a
	Qt-based application. It allows you to load and modify language files
	(.qm), and notify the application when the language changes. The class
	uses Qt's signals and slots mechanism to interact with other components
	of the application.

	:param engine: An object that is responsible for redrawing the application
	interface (such as the main window or QML engine).
	"""

	langChanged: Signal = Signal()
	langList: Signal = Signal(list)

	def __init__(self, engine) -> None:
		QObject.__init__(self)

		self._translator = None
		self._engine = engine

		self._lang_list = {
			"English": ":/languages/lang_en.qm",
			"Russian": ":/languages/lang_ru.qm",
		}

	@Property(list, notify=langList)
	def languages(self) -> list[str]:
		""" Property that returns a list of available languages.

		:return: List of strings with language names (e.g. ["English",
		"Russian"]).
		"""
		return list(self._lang_list.keys())

	@Slot(str)
	def load_language(self, lang_name: str) -> None:
		""" Method to load and set the language in an application.

		:param lang_name: The name of the language to load (e.g., "English"
		or "Russian").
		"""

		if self._translator is not None:
			QCoreApplication.instance().removeTranslator(self._translator)

		self._translator = QTranslator()
		if self._translator.load(self._lang_list[lang_name]):

			if QCoreApplication.instance().installTranslator(self._translator):
				self._engine.retranslate()

			self.langChanged.emit()
