#!/bin/bash
# Pulls git repos needed for development and custom lsurice mason


mkdir repos

# Mason website skins
git clone git@github.com:ch728/famosolab-breedbase.git repos/famosolab-breedbase

# main code
git clone https://github.com/solgenomics/cxgn-corelibs.git repos/cxgn-corelibs
git clone https://github.com/solgenomics/sgn.git  repos/sgn
git clone https://github.com/solgenomics/Phenome.git repos/Phenome
git clone https://github.com/solgenomics/sgn-devtools.git repos/sgn-devtools
git clone https://github.com/solgenomics/solGS.git repos/solGS
git clone https://github.com/solgenomics/DroneImageScripts.git repos/DroneImageScripts

# local libs
git clone https://github.com/solgenomics/perl-local-lib repos/local-lib
git clone https://github.com/solgenomics/R_libs repos/R_libs
