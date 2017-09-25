#!/usr/bin/env python3

import sys

str_input = sys.stdin.read()
tab_input = str_input.split('\n')

line_ctr = 0
ok_ctr = 0

for line in tab_input:
	if ':' in line:
		if line.split(':')[-1].strip() == 'ok':
			ok_ctr += 1
		line_ctr += 1

res = "Found {} correct lines, among them {} lines were \"ok\"".format(line_ctr, ok_ctr)
print(res)