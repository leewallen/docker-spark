#!/bin/bash

tar -xvzf count-letters.tgz

mkdir -p ../data
mkdir -p ../jars
mkdir -p ../scripts

cp ./count-letters/data/*.* ../data/
cp ./count-letters/jars/*.* ../jars/
cp ./count-letters/scripts/*.* ../scripts/
chmod +x ../scripts/run-example.sh
