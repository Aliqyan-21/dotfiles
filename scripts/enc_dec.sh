#!/bin/bash

if [ $# -ne 5 ]; then
  echo "usage: ossl [r|b|xdb|tenc] [enc|dec] [input file] [key] [output file]"
  exit 1;
fi

TYPE=$1; WHAT=$2; IN=$3; KEY=$4; OUT=$5

if [[ "$TYPE" == "r" || "$TYPE" == "b" ]]; then
  ALGO="idea-cbc"
  IV="9238173e167a284b"
elif [[ "$TYPE" == "xdb" || "$TYPE" == "tenc" ]]; then
  ALGO="aes-256-cbc"
  IV="d750a6297358021ea094cc46f112cef3"
else
  echo "Error Unsupported file type."
  exit 1
fi

if [ "$WHAT" == "enc" ]; then
  openssl enc -"$ALGO" -in "$IN" -out "$OUT"  -K $KEY -iv "$IV" -provider legacy
elif [ "$WHAT" == "dec" ]; then
  openssl enc -d -"$ALGO" -in "$IN" -K $KEY -iv "$IV" -out "$OUT" -provider legacy
else
    echo "'enc' or 'dec' should be sued for encryption/decryption respectively."
    exit 1
fi
