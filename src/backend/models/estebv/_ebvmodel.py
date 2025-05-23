#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2024-2026 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

"""
EBV (Estimated Breeding Value) Model Module.

This module provides the EbvModel class which handles configuration and data
management for Estimated Breeding Value calculations in animal breeding
programs.
"""

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"
__all__ = ('EbvModel',)

from PySide6.QtCore import (
	QObject,
	Slot,
	Signal,
	Property
)

from ._conformvmodel import ConformVarModel
from ._gencfgvar import GeneratorCfgVar
from ._milkvmodel import MilkVarModel
from ._reprodvmodel import ReprodVarModel
from ._scsvmodel import ScsVarModel
from ...libkrs.core.settings import CMD_FEATURE
from ...libkrs.utils import (
	logger,
	from_json,
	to_json
)


@logger(name="EbvModel")
class EbvModel(QObject):
	""" Model class for managing EBV (Estimated Breeding Value) configurations.

	This class provides:
	- Management of variance configurations for different breeding traits.
	- Serialization/deserialization of configuration data.
	- Feature list and table structure definitions.
	- Integration with variance configuration generators.

	Signals:
		getLstFeature(list): Emitted with available breeding features.
		sigFtVarModel(): Emitted when feature variance models change.
		genCfgVarSig(): Emitted when generator configuration changes.

	Properties:
		generator_var (GeneratorCfgVar): Variance configuration generator.
		list_feature (list[str]): Available breeding features.
		ft_var_model (dict): Mapping of features to their variance models.
	"""

	__slots__ = (
		"__generator_cfg_var",
		"_milk_v_model",
		"_conform_v_model",
		"_reprod_v_model",
		"_scs_v_model",
	)

	getLstFeature = Signal(list)
	sigFtVarModel = Signal()

	genCfgVarSig = Signal()

	def __init__(self) -> None:
		"""Initialize the EBV model with a variance configuration generator."""
		QObject.__init__(self)

		self.__generator_cfg_var = GeneratorCfgVar()

		self._milk_v_model = MilkVarModel()
		self._conform_v_model = ConformVarModel()
		self._reprod_v_model = ReprodVarModel()
		self._scs_v_model = ScsVarModel()

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

	@Property(dict, notify=sigFtVarModel)
	def ft_var_model(self) -> dict:
		""" Get the mapping of features to their variance models.

		:return: Dictionary mapping feature names to variance models.
		:rtype: dict[str, object]
		"""
		return dict(zip(
			CMD_FEATURE,
			[
				self._milk_v_model,
				self._conform_v_model,
				self._reprod_v_model,
				self._scs_v_model
			]
		))

	@Slot(str, str)
	def save_variance_conf(self, ft_name: str, path_file: str) -> None:
		""" Save variance configuration to a JSON file.

		:param ft_name: Feature name to save configuration for.
		:type ft_name: str
		:param path_file: Path to output JSON file.
		:type path_file: str
		:return: None
		"""
		to_json(self.ft_var_model.get(ft_name).get_data, path_file)

	@Slot(str, str)
	def load_variance_conf(self, ft_name: str, path_file: str) -> None:
		""" Load variance configuration from a JSON file.

		:param ft_name: Feature name to load configuration for.
		:type ft_name: str
		:param path_file: Path to input JSON file.
		:type path_file: str
		:return: None
		"""
		data = from_json(path_file)

		self.ft_var_model.get(ft_name).set_data(data)
