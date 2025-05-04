#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

"""
Index Handler Module.

Provides the IndHandler class for processing index calculation requests.
"""

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('IndHandler', )

from pathlib import Path

from pydantic_core import ValidationError

from .ihandler import IHandler
from ..libkrs.givc import PreparationGIVC
from ..libkrs.index import (
    IndFeature,
    ComplexIndex
)
from ..libkrs.utils import logger
from ..schemas import RequestInd


@logger(name="IndHandler")
class IndHandler(IHandler):
    """ Handler for index calculation requests.

    Processes index queries and supports three calculation methods:
        - Individual index calculation
        - Complex index calculation
        - Data processing for GIVC (Genetic Index Value Calculation)
    """

    def __init__(
            self,
            req_data: dict | None = None,
            output_dir: str | Path | None = None
    ) -> None:
        """ Initialize the IndHandler instance.

        :param req_data: Input data for configuring the index processing.
        :type req_data: dict | None.
        :param output_dir: Directory for saving output results.
        :type output_dir: str | Path | None.
        :raises ValidationError: If the input data fails validation.
        :raises Exception: For any other errors during initialization.
        """
        self._out_d = output_dir
        self._settings: RequestInd | None = None

        try:
            if req_data is not None:
                self._settings = RequestInd.model_validate(req_data)

        except (ValidationError, Exception) as err:
            raise err

    def processing(self) -> None:
        """Process the index calculation request.

        :raises ValueError: If settings are not initialized
        :return: None
        """
        if self._settings is None:
            raise ValueError("Settings not initialized!")

        if not self._settings.gengivc.status:

            if self._settings.index:
                self._handler_index()

            elif self._settings.complex_i:
                self._handler_cindex()

        else:
            self._handler_givc()

    def _handler_index(self) -> None:
        """ Handle individual index calculation.

        :return: None
        """
        _args = {
            "feature": None,
            "dir_nspace": self._out_d,
            "animal": self._settings.animal,
            "division": self._settings.divdata,
            "est_method": self._settings.estmethod,
            "parallel": self._settings.parallel,
            "workers": None if self._settings.numthread is None
            else int(self._settings.numthread),
            "disabled_optim": self._settings.disableoptim
        }

        if self._settings.auto and isinstance(self._settings.feature, list):
            for item_ft in self._settings.feature:
                _args.update({"feature": item_ft})

                ind = IndFeature(**_args)
                ind.run()
            return

        _args.update({"feature": self._settings.feature})
        ind = IndFeature(**_args)
        ind.run()

    def _handler_cindex(self) -> None:
        """ Handle complex index calculation.

        :return: None
        """
        cind = ComplexIndex(
            animal=self._settings.animal,
            division=self._settings.divdata,
            method_est=self._settings.estmethod,
            dir_nspace=self._out_d
        )
        cind.run_cind()

    def _handler_givc(self) -> None:
        """ Handle GIVC (Genetic Index Value Calculation) preparation.

        :return: None
        """
        givc = PreparationGIVC(
            dir_files=Path(self._settings.gengivc.dirreport),
            animal=self._settings.gengivc.typereport
        )
        givc.handle()
