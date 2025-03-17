#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('RequestSnp', )

from pydantic import BaseModel


# -- Description of the configuration settings for processing the SNP --
class SnpM(BaseModel):
	checked: bool
	refsnpfile: None | str
	samplefile: None | str
	updatefile: None | str


class SaveCrFileM(BaseModel):
	checked: bool
	filename: None | str


class AddSuffM(BaseModel):
	checked: bool
	add: bool
	fromfile: None | str


class FinalReportM(BaseModel):
	checked: bool
	dirfilefr: None | str
	callrate: None | str
	savecrfile: SaveCrFileM
	addsuff: AddSuffM


class RequestSnp(BaseModel):
	id: str
	snp: SnpM
	fr: FinalReportM
