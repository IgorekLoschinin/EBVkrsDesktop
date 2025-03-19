#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('SettingsManager', )


from PySide6.QtCore import (
	QObject,
	QSettings,
	Property,
	Signal
)


class SettingsManager(QObject):
	""" Объект для управления настройками и системой авторизации """

	def __init__(self) -> None:
		QObject.__init__(self)

		self._settings = QSettings("EBVkrsDesc", "app")
		self._theme = self._settings.value("theme", "light")

	# Сигнал для уведомления QML об изменении темы
	themeChanged = Signal(str)

	# Свойство для работы с темой
	@Property(str, notify=themeChanged)
	def theme(self):
		return self._theme

	@theme.setter
	def theme(self, value):
		if self._theme != value:
			self._theme = value
			self._settings.setValue("theme", value)
			self.themeChanged.emit(value)

	# Метод для сброса настроек
	def resetSettings(self):
		self._settings.clear()
		self.theme = "light"

