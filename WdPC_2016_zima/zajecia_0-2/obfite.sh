#!/bin/bash

for ((i=0;;i++)); do
	./obfitegen $i > obfite.in
	./Obfite < obfite.in > obfite.out
	./szachu <obfite.in > obfite2.out
	if diff -bq obfite.out obfite2.out; then echo "$i OK"
	else break
	fi
done