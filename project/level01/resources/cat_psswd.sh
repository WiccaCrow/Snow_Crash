#!/bin/bash

cat /etc/passwd | grep flag01 | grep -E -o ':.............:' | grep -E -o '[^(':')](.*)[^(':')]'
