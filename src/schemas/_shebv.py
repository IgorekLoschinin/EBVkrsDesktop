#!/usr/bin/env python
# coding: utf-8

from pydantic import BaseModel


# -- Description of the configuration settings for processing the EBV --
class VarianceM(BaseModel):
	...


class RequestEbv(BaseModel):
	id: str
	estmethod: str
	feature: str
	variance: dict  #VarianceM  #- словарь с вариансами
	parallel: bool
	numthread: None | str
