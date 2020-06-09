#!/bin/bash

export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64

for PYBIN in /opt/python/*/bin; do
  echo "Checking git status before running bdist_wheel on $PYBIN/pypy"
  git status
  $PYBIN/python setup.py bdist_wheel -d pypy-dist
done

for whl in $(ls pypy-dist/*.whl); do
  auditwheel repair -w pypy-wheelhouse $whl
done
