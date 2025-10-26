#!/bin/bash

if [ $# -ne 1 ]; then
  echo "使い方: $0 <ファイル名(拡張子なし)>"
  exit 1
fi

XX=$1
gcc -m32 stub.c x86/libmincaml.S test/${XX}.s -lm -o test/${XX}
