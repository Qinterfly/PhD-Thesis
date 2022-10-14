#!/bin/bash
# Remove temporary LaTeX files

find -type f \( -name "*.aux" -o -name "*.log" \) -exec rm {} \;
