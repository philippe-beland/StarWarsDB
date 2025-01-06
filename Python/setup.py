# -*- coding: utf-8 -*-
"""
Created on Fri Dec 20 13:34:08 2022

@author: Philippe
"""

import os
import pathlib
from setuptools import setup, find_packages

HERE = pathlib.Path(__file__).parent

PACKAGE_NAME = "StarWarsDB"
AUTHOR = "Philippe Béland"
AUTHOR_EMAIL = "phil_beland@hotmail.com"
URL = ""

DESCRIPTION = "Various tools for StarWarsDb purposes"
LONG_DESCRIPTION = (HERE / "README.md").read_text()
LONG_DESC_TYPE = "text/markdown"


def get_version():
    with open(os.path.join(HERE, PACKAGE_NAME, "VERSION")) as file_version:
        version = file_version.read()
    return version


def parse_requirements(file):
    return sorted(
        set(
            line.partition("#")[0].strip()
            for line in open(os.path.join(os.path.dirname(__file__), file))
        )
        - set("")
    )


setup(
    name=PACKAGE_NAME,
    version=get_version(),
    description=DESCRIPTION,
    long_description=LONG_DESCRIPTION,
    long_description_content_type=LONG_DESC_TYPE,
    include_package_data=True,
    author=AUTHOR,
    author_email=AUTHOR_EMAIL,
    url=URL,
    install_requires=parse_requirements("requirements.txt"),
    packages=find_packages(),
)
