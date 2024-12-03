#!/usr/bin/env python
# coding: utf-8

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
