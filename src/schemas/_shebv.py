#!/usr/bin/env python
# coding: utf-8

from pydantic import BaseModel


# -- Description of the configuration settings for processing the EBV --
class EstMethodM(BaseModel):
	blup: bool
	gblup: bool


class RequestEbv(BaseModel):
	id: str
	estmethod: EstMethodM
	feature: str
	# variance: Variance - словарь с вариансами
	parallel: bool
	numthread: None | str
