#!/usr/bin/env python
# coding: utf-8

# Copyright (C) 2023-2024 Igor Loschinin.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.

__author__ = "Igor Loschinin (igor.loschinin@gmail.com)"

from pathlib import Path
from pydantic_core import ValidationError

from .imodel import IModel
from ..schemas import RequestEbv


class EbvModel(IModel):
	"""  """

	def __init__(
			self,
			req_data: dict | None = None,
			output_dir: str | Path | None = None
	) -> None:

		self._out_d = output_dir
		self._settings: RequestEbv | None = None

		try:
			if req_data is not None:
				self._settings = RequestEbv.model_validate(req_data)

		except (ValidationError, Exception) as err:
			raise err

	def processing(self) -> None:
		"""
		            match self._opts.options.method:
                case "blup":
                    ebv = Estimator(
                        feature=self._opts.options.feature,
                        vars_f=self._opts.variance,
                        namespace=self.common_namespace,
                        parallel=self._opts.options.parallel,
                        workers=self._opts.options.num_workers
                    )
                    ebv.start()

                case "gblup":
                    gebv = GEstimator(
                        feature=self._opts.options.feature,
                        vars_f=self._opts.variance,
                        namespace=self.common_namespace,
                        parallel=self._opts.options.parallel,
                        workers=self._opts.options.num_workers
                    )
                    gebv.start()

            return None
		"""
