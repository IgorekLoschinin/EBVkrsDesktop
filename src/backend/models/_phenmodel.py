#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('PhenoModel', )

from PySide6.QtCore import (
	QObject,
	Signal,
	Property
)

from ..libkrs.core.settings import CMD_FEATURE
from ..libkrs.utils import logger


@logger(name="PhenoModel")
class PhenoModel(QObject):
	""" """

	getLstFeature = Signal(list)

	def __init__(self) -> None:
		QObject.__init__(self)

	@Property(list, notify=getLstFeature)
	def list_feature(self) -> list[str]:
		""" Возвраащет список команд - названий признаков для расчета на EBVpage """
		return CMD_FEATURE
