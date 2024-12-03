#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2023-2024 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"

import sys

from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from src import Backend


if __name__ == "__main__":

	app = QGuiApplication([])
	engine = QQmlApplicationEngine()

	main = Backend()
	engine.rootContext().setContextProperty("backend", main)

	engine.load(Path(__file__).parent / "src/gui/gui.qml")

	if not engine.rootObjects():
		sys.exit(-1)

	sys.exit(app.exec())
