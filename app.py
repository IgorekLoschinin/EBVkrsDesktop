#!/usr/bin/env python
# coding: utf-8

import sys

from pathlib import Path

from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine


class Backend(QObject):

	# printPheno = Signal(dict)

	def __init__(self) -> None:
		QObject.__init__(self)

	@Slot(dict)
	def printFormProc(self, data: dict):
		print(data)


if __name__ == "__main__":

	app = QGuiApplication([])
	engine = QQmlApplicationEngine()

	main = Backend()
	engine.rootContext().setContextProperty("backend", main)

	engine.load(Path(__file__).parent / "src/gui/gui.qml")

	if not engine.rootObjects():
		sys.exit(-1)

	sys.exit(app.exec())
