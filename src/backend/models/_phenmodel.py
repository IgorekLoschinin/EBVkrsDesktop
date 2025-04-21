#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

"""
Phenotype Model Module.

Provides the PhenoModel class which manages phenotype feature data
for breeding value calculations.
"""

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
    """ Model class for managing phenotype feature data.

    Provides access to the list of available phenotype features used in
    breeding value calculations.
    """

    __slots__ = ()

    getLstFeature = Signal(list)

    def __init__(self) -> None:
        """ Initialize the PhenoModel instance.

        :return: None
        """
        QObject.__init__(self)

    @Property(list, notify=getLstFeature)
    def list_feature(self) -> list[str]:
        """ Get the list of available phenotype features.

        :return: List of phenotype feature names for EBV calculations.
        :rtype: list[str]
        """
        return CMD_FEATURE
