#!/usr/bin/env bash

pushd $(dirname $0)

finish() {
  result=$?
  popd
  exit ${result}
}

trap finish EXIT ERR

cat *.custom *.txt > ../all-emojis.txt
