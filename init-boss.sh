#!/usr/bin/env bash

cd besenv 

source setupCMT.sh

cmt config

cd $HOME/bes/chic2invi/v0.1/TestRelease/TestRelease-00-00-84/cmt

cmt br cmt config

cmt br gmake

cd $HOME/bes/chic2invi/v0.1






