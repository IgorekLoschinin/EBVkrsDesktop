#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

"""
EBV (Estimated Breeding Value) Model Module.

This module provides the EbvModel class which handles configuration and data
management for Estimated Breeding Value calculations in animal breeding programs.
"""

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('EbvModel',)

from PySide6.QtCore import (
	QObject,
	Slot,
	Signal,
	Property
)

from ...libkrs.core.settings import CMD_FEATURE
from ...libkrs.est.varmodel import (
	FEATURE_NAME_SCS,
	FEATURE_NAME_MILK,
	FEATURE_NAME_REPROD,
	FEATURE_NAME_CONFORM
)
from ...libkrs.utils import (
	logger,
	from_json,
	to_json
)

from ._gencfgvar import GeneratorCfgVar


@logger(name="EbvModel")
class EbvModel(QObject):
	""" Model class for managing EBV (Estimated Breeding Value) configurations
	and data.

	This class provides:
		- Management of variance configurations for different breeding traits
		- Serialization/deserialization of configuration data
		- Feature list and table structure definitions for EBV calculations
		- Integration with variance configuration generators

	Signals:
		uploadVar(dict): Emitted when variance configuration data is loaded
		getLstFeature(list): Emitted with list of available breeding features
		getfieldsTable(dict): Emitted with table structure for EBV features
		genCfgVarSig(): Emitted when generator configuration changes

	Properties:
		generator_var (GeneratorCfgVar): Access to variance configuration generator
		list_feature (list[str]): List of available breeding features
		get_fields_table (dict[str, list[str]]): Table structure for EBV features
	"""

	__slots__ = ("__generator_cfg_var",)

	uploadVar = Signal(dict)
	getLstFeature = Signal(list)
	getfieldsTable = Signal(dict)
	genCfgVarSig = Signal()

	def __init__(self) -> None:
		"""Initialize the EBV model with a variance configuration generator."""
		QObject.__init__(self)

		self.__generator_cfg_var = GeneratorCfgVar()

	@Property(GeneratorCfgVar, notify=genCfgVarSig)
	def generator_var(self) -> GeneratorCfgVar:
		""" Get the variance configuration generator instance.

		:return GeneratorCfgVar: The variance configuration generator.
		"""
		return self.__generator_cfg_var

	@Property(list, notify=getLstFeature)
	def list_feature(self) -> list[str]:
		""" Get the list of available breeding features for EBV calculation.

		:return list[str]: List of feature names used in EBV calculations.
		"""
		return CMD_FEATURE

	@Property(dict, notify=getfieldsTable)
	def get_fields_table(self) -> dict[str, list[str]]:
		""" Get the table structure mapping features to their display fields.

		:return dict[str, list[str]]: Dictionary where keys are feature
			names and values are lists of display fields.
		"""
		return dict(zip(
			CMD_FEATURE,
			[
				FEATURE_NAME_MILK,
				FEATURE_NAME_CONFORM,
				FEATURE_NAME_REPROD,
				FEATURE_NAME_SCS
			]
		))

	@Slot(dict, str)
	def save_variance_conf(self, data: dict[str, dict], path_file: str) -> None:
		""" Save variance configuration data to a JSON file.

		:param data: Dictionary containing variance configuration data
			Structure: {feature_name: configuration_dict} path_file: Path to
			the output JSON file.

		:return: None
		"""
		to_json(data, path_file)

	@Slot(str)
	def load_variance_conf(self, path_file: str) -> None:
		""" Load variance configuration from a JSON file and emit uploadVar
		signal.

		:param path_file: Path to the JSON configuration file.

		Emits:
			uploadVar: Signal with the loaded configuration data

		:return: None
		"""
		data = from_json(path_file)

		self.uploadVar.emit(data)
