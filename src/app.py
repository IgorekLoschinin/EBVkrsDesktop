#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2023-2024 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"

import sys
from resources import (
	icons,
	languages
)

from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from backend import (
	Backend,
	TranslationManager
)


if __name__ == "__main__":

	app = QGuiApplication([])
	engine = QQmlApplicationEngine()

	# Create and upload a translator
	translator = TranslationManager(engine)
	engine.rootContext().setContextProperty("translationManager", translator)

	main = Backend()
	engine.rootContext().setContextProperty("backend", main)

	engine.load(Path(__file__).parent / "gui/gui.qml")

	if not engine.rootObjects():
		sys.exit(-1)

	sys.exit(app.exec())
