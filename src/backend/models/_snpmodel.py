#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('SnpModel', )


from PySide6.QtCore import QObject

from ..libkrs.utils import logger


@logger(name="SnpModel")
class SnpModel(QObject):
	"""  """
