#!/usr/bin/env python
# coding: utf-8

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
