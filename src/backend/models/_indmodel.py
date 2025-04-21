#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

"""
Individual Model Module.

This module provides the IndModel class which manages feature lists
for individual breeding value calculations in animal breeding programs.
"""

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('IndModel',)

from PySide6.QtCore import (
	QObject,
	Signal,
	Property
)

from ..libkrs.core.settings import CMD_FEATURE
from ..libkrs.utils import logger


@logger(name="IndModel")
class IndModel(QObject):
	""" Model class for managing individual breeding feature information.

	This class provides:
	- Access to the list of available breeding features
	- Signal emission when feature list is accessed

	Signals:
		getLstFeature(list): Emitted with list of available breeding features
							when list_feature property is accessed.

	Properties:
		list_feature (list[str]): List of available breeding features for
								individual EBV calculations.
	"""

	__slots__ = ()  # Optimization: prevents creation of instance dictionary

	getLstFeature = Signal(list)

	def __init__(self) -> None:
		""" Initialize the Individual Model. """
		QObject.__init__(self)

	@Property(list, notify=getLstFeature)
	def list_feature(self) -> list[str]:
		""" Get the list of available breeding features for individual EBV
		calculation.

		This property provides access to the predefined list of breeding
		features that can be used for Estimated Breeding Value calculations
		on the EBV page.

		:return list[str]: List of feature names/commands used in individual
			EBV calculations. The list comes from the CMD_FEATURE configuration.

		Note:
			Accessing this property will emit the getLstFeature signal with
			the feature list.
		"""
		return CMD_FEATURE
