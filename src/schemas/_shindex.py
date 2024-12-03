#!/usr/bin/env python
# coding: utf-8

from pydantic import BaseModel


# -- Description of the configuration settings for processing the index --
class EstMethodM(BaseModel):
	blup: bool
	gblup: bool


class GivcModel(BaseModel):
	status: bool
	dirreport: None | str
	typereport: str


class RequestInd(BaseModel):
	id: str
	estmethod: EstMethodM
	feature: str
	animal: str
	typeind: str
	divdata: bool
	parallel: bool
	numthread: None | str
	disableoptim: bool
	gengivc: GivcModel
