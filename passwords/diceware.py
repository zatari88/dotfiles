#!/usr/bin/env python3

from numpy import loadtxt
import secrets

# The dtype field specifies the datatype. The string formatter will
# only accept formats with specified lengths. 'S100" to be sure I will
# have enough space for any of the words
lines = loadtxt("eff_large_wordlist.txt", dtype= {'names': ('DiceSeq', 'Word'),
                                                  'formats': ('S5', 'S100')})

for i in range(6):
    # there are 7776 different possible outcomes of 5 dice rolls
    # use secrets to generate random value as it should be
    # a cryptographically secure random value
    r = secrets.randbelow(7776)
    print(lines[r][1].decode(), end=" ")

print("\n")
