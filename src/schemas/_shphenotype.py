#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2023-2024 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"

from pydantic import BaseModel


# -- Description of the configuration settings for processing the phenotype --
class UpdataDBM(BaseModel):
	checked: bool
	pathto: None | str
	pathfrom: None | str


class SearchDaughM(BaseModel):
	datafiles: None | str
	filesires: None | str


class PreparationM(BaseModel):
	checked: bool
	updatabd: UpdataDBM
	searchdaug: SearchDaughM


class SelectDataM(BaseModel):
	checked: bool
	filefarm: None | str
	removedaug: None | str


class RequestPheno(BaseModel):
	id: str
	preparation: PreparationM
	phendata: None | str
	feature: None | str
	accummeth: bool
	numlact: int
	ped: bool
	daughters: bool
	selectdata: SelectDataM