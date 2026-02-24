#!/bin/bash

ROUTE_KEY="caf3fe5cdbc3e458dc97cc8372c0f962"
BITSTREAM_KEY="61c921376f8fc76e6305ee6ab3ea7aa6"  
IV="9238173e167a284b"

if [ "$#" -ne 3 ]; then
    echo "Usage: ./decrypt_file.sh <input_file> <output_file> <mode>"
    echo "  input_file: Path to the input file"
    echo "  output_file: Path to the output file"
    echo "  mode: 'route (r)' or 'bitstream (b)'"
    exit 1
fi

input_file=$1
output_file=$2
mode=$3

if [ ! -f "$input_file" ]; then
    echo "Error: Input file does not exist!"
    exit 1
fi

key=""
if [ "$mode" == "r" ]; then
    key=$ROUTE_KEY
elif [ "$mode" == "b" ]; then
    key=$BITSTREAM_KEY
else
    echo "Error: Invalid mode selected. Use 'r' or 'b'."
    exit 1
fi

openssl enc -d -idea -in $input_file -out $output_file -K $key -iv $IV -provider legacy

if [ $? -eq 0 ]; then
    echo "Decryption successful! Output saved to: $output_file"
else
    echo "Decryption failed!"
    exit 1
fi
