#!/bin/bash

usage() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "-t <value> - Target to build for"
  echo "-b <value> - Bootstrap for plaform, possible values: f25"
}

while getopts "b:t:" o; do
  case "${o}" in
    b)
        bootstrap=${OPTARG}
        ;;
    t)
        target=${OPTARG}
        ;;
  esac
done

shift $((OPTIND-1))

case "${bootstrap}" in
  f25)
    sudo dnf install -y automake autoconf ccache gcc flex bison file unzip cmake gcc-c++ bc wget python patch perl-ExtUtils-MakeMaker-CPANfile awscli
    ;;
esac

cp nepos/configs/buildroot/nepos-${target}.config .config
make
