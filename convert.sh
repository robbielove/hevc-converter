# load the folder path from the command line

# set the folder path
folderPath=""

# set the output folder path
outputFolderPath=""

# iterate through the files in the folder
for file in "$folderPath"/*
do
    # get the file name
    fileName=$(basename "$file")
    # get the file extension
    fileExtension="${fileName##*.}"
    # get the file name without the extension
    fileNameNoExtension="${fileName%.*}"
    # set the output file path
    outputFilePath="$outputFolderPath/$fileName"
    # convert the file to h265 (create the m4v file if it does not exist), keep file creation and modification times the same, overwrite the output file if it exists
    ffmpeg -i "$file" -c:v libx265 -vtag hvc1 -crf 23 -preset veryfast -c:a copy -map_metadata -1 -movflags +faststart -y "$outputFilePath"
    # use touch to sync the creation and modification times
    touch -r "$file" "$outputFilePath"
done
