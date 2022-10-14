#!/bin/bash
# Archive the main content of the disseration, synopsis and presentation

# Create a list of files to archive
listArchive=$(ls | grep -v "archive" | grep -v "documents" | grep -v "literature" | grep -v "program" | grep -v "test")

# Create an archive
dirArchive="archive"
tempNameArchive="tempArchive.zip"
echo $listArchive | xargs zip -r "$dirArchive/$tempNameArchive"

# Set the archive name
cd $dirArchive
nameArchive="[$(date +"%Y.%m.%d")].zip"
if [[ ! -f $nameArchive ]]; then
    mv $tempNameArchive "$nameArchive"
    echo "$nameArchive was successfully created"
else
    echo "$nameArchive already exists. The name of the created archive is $tempNameArchive"
fi
