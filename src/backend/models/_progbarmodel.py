#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

"""
Progress Bar Model Module.

Provides the ProgBarModel class which manages the state and behavior
of progress bar indicators in the application.
"""

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('ProgBarModel', )

from PySide6.QtCore import (
    QObject,
    Signal,
    Property
)

from ..libkrs.utils import logger


@logger(name="ProgBarModel")
class ProgBarModel(QObject):
    """ Model class for managing progress bar state and behavior.

    Provides properties and signals for controlling:
        - Progress bar visibility.
        - Process completion status.
        - Process result codes.
    """

    __slots__ = (
        "_finished",
        "_finished_code",
        "_enable_prg_win",
    )

    enablePrgW = Signal(bool)
    finishedCodeSig = Signal(int)
    finishedSig = Signal(int)

    def __init__(self) -> None:
        """ Initialize the ProgBarModel instance.

        :return: None
        """
        QObject.__init__(self)

        self._finished: bool = False
        self._finished_code: int | None = None
        self._enable_prg_win: bool = False

    @Property(bool, notify=enablePrgW)
    def enable_prg_win(self) -> bool:
        """ Get the progress bar visibility state.

        :return: True if progress bar should be visible, False otherwise.
        :rtype: bool
        """
        return self._enable_prg_win

    @enable_prg_win.setter
    def enable_prg_win(self, value: bool) -> None:
        """ Set the progress bar visibility state.

        :param value: True to show progress bar, False to hide.
        :type value: bool
        :return: None
        """
        if self._enable_prg_win != value:
            self._enable_prg_win = value
            self.enablePrgW.emit(value)

    @Property(int, notify=finishedCodeSig)
    def finished_code(self) -> int | None:
        """ Get the process completion code.

        :return: Process completion code (0=Success, 1=Error, -1=Processing).
        :rtype: int | None
        """
        return self._finished_code

    @finished_code.setter
    def finished_code(self, value: int) -> None:
        """ Set the process completion code.

        :param value: Completion code (0=Success, 1=Error, -1=Processing).
        :type value: int
        :return: None
        """
        if self._finished_code != value:
            self._finished_code = value
            self.finishedCodeSig.emit(value)

    @Property(int, notify=finishedSig)
    def finished(self) -> int | None:
        """ Get the process completion status.

        :return: True if process is finished, False otherwise.
        :rtype: int | None
        """
        return self._finished

    @finished.setter
    def finished(self, value: bool) -> None:
        """ Set the process completion status.

        :param value: True if process is finished, False otherwise.
        :type value: bool
        :return: None
        """
        if self._finished != value:
            self._finished = value
            self.finishedSig.emit(value)
