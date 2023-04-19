#!/bin/bash
# $1 -- формат (C5 или A4)

# Параметры файла с адресатами
baseFileName="source"
fileExtension=".csv"
baseOutputFileName="letters"

# Проверка корректности формата
fileFormat=$1
if [[ $fileFormat == "C5" || $fileFormat == "A4" ]]; then
	inputFileName="$baseFileName-$fileFormat$fileExtension"
	outputFileName="letters-$fileFormat.pdf"
else
	echo "File format is not supported. Try using 'C5' or 'A4'"
	exit
fi

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
						    \input{$baseOutputFileName-$fileFormat.tex}"
done < $inputFileName

# Объединение конвертов
rm -f $outputFileName
pdftk $(find -name "$baseOutputFileName*.pdf" -prune -o -name '*.pdf' -print | sort -V) cat output $baseOutputFileName.pdf.backup
rm -f *.aux *.log $(find -name "$baseOutputFileName*.pdf" -prune -o -name '*.pdf' -print)
mv $baseOutputFileName.pdf.backup $outputFileName
