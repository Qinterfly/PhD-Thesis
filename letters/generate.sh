#!/bin/bash

fileName="source.csv"

iRow=0

# Создание всех конвертов
while IFS=$'\t' read -r index city address institution whom
do
	((iRow=iRow+1))
	xelatex -jobname $iRow "\def\toindex{$index} \
						    \def\tocity{$city} \
						    \def\toaddress{$address} \
						    \def\toinstitution{$institution} \
						    \def\towhom{$whom} \
						    \input{letters.tex}"
done < $fileName

# Объединение конвертов
rm -f letters.pdf
pdftk $(find -name "*.pdf" | sort -V) cat output letters.pdf.backup
rm -f *.aux *.log *.pdf
mv letters.pdf.backup letters.pdf
