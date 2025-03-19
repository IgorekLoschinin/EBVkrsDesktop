#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('RequestInd', )

from pydantic import BaseModel


# -- Description of the configuration settings for processing the index --
class GivcModel(BaseModel):
	status: bool
	dirreport: None | str
	typereport: str


class RequestInd(BaseModel):
	id: str
	estmethod: str
	feature: str
	animal: str
	index: bool
	complex_i: bool
	divdata: bool
	parallel: bool
	numthread: None | str
	disableoptim: bool
	gengivc: GivcModel
