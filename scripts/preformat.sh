#!/bin/bash
# Preformat the latex file

pdftex -ini -jobname="$1-preformat" "&pdflatex" mylatexformat.ltx """$1.tex"""
