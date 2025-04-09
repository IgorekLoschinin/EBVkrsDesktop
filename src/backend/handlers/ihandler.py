#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('IHandler', )

from abc import ABC, abstractmethod


class IHandler(ABC):

	@abstractmethod
	def processing(self, *args, **kwargs) -> None:
		raise NotImplementedError
