#!/bin/bash

for ((i;;i++)) do
  ./zligen $i >zli.in
  ./zlicz <zli.in >zli1.out
  ./zli <zli.in >zli2.out
  if diff -bq zli1.out zli2.out 
    then echo "$i OK"
    else break
  fi
done