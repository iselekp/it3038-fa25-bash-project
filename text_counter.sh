#!/bin/bash

# Function to display script usage/help information
function display_usage() {
  # hint: you will have multiple echo statements here
  echo "Usage: $0 -f <filename> -o <output_dir> -t <type>"
  echo "Options:"
  echo "  -f <filename>: Specify the input filename."
  echo "  -o <output_dir>: Specify the output directory where the results will be stored."
  echo "  -t <type>: Specify the type of action to perform. Supported types are 'line', 'word' and 'sentence'."
  echo "  -h: Display this help information."
}

# Check if no arguments are provided.
# If so, display usage information and exit
if [[ $# -eq 0 || "$1" == '-h' ]]; then
    display_usage
    exit 0
fi

# Initialize variables (you don't need to change this part)
filename=""
output_dir=""
action=""

# Process command-line options and arguments
while getopts ":f:o:t:h" opt; do
    case $opt in
        f) # option f
            filename=$OPTARG
            ;;
        o) # option o
            output_dir=$OPTARG
            ;;
        t) # option t
            action=$OPTARG
            ;;
        h) # option h
            # display usage and exit
            display_usage
            exit 0
            ;;
        \?) # any other option
            echo "Invalid option: -$OPTARG"
            # display usage and exit
            display_usage
            exit 0
            ;;
        :) # no argument
            echo "Option -$OPTARG requires an argument."
            # display usage and exit
            display_usage
            exit 0
            ;;
    esac
done

# Check if all required switches are provided (f, o, t are required. since each of these sets a variable, you can use those variables to know if the option was provided)
    if [[ -z $filename || -z $output_dir || -z $action ]]; then
        echo "Error: Missing required options."
        # display usage and exit
        display_usage
        exit 1
    fi

# Check if the -t switch has a valid argument
    if [[ $action != "line" && $action != "word" && $action != "sentence" ]]; then
        echo "Error: Invalid action type. Supported types are 'line', 'word' and 'analyze'."
        # exit
        exit 1
    fi

# Check if the specified input filename exists and is a regular file
    if [[ ! -f $filename ]]; then
        echo "Error: Input file '$filename' does not exist or is not a regular file."
        # exit
        exit 1
    fi

# Check if the specified output directory exists and is a directory
    if [[ ! -d $output_dir ]]; then
        echo "Error: Output directory '$output_dir' does not exist."
        # exit
        exit 1
    fi

# Perform the selected action based on the user input
# if action is line
    if [[ $action == "line" ]]; then
        # count the number of lines in the text file
        echo "Counting the number of lines in '$filename' and the results will be stored in '$output_dir'."
        lines=$(wc -l $filename | sed -n -e 's/^\([0-9]\+\).*/\1/p')
        echo "There are $lines lines in $filename" > "$output_dir/results.txt"
# else if action is word
    elif [[ $action == "word" ]]; then
        # count the number of words in the text file
        echo "Counting the number of words in '$filename' and the report will be stored in '$output_dir'."
        words=$(wc -w $filename | sed -n -e 's/^\([0-9]\+\).*/\1/p')
        echo "There are $words words in $filename" > "$output_dir/results.txt"
#else if action is sentence
    elif [[ $action == "sentence" ]]; then
        # count the number of sentences in the text file
        echo "Counting the number of sentences in '$filename' and the report will be stored in '$output_dir'."
        sentences=$(grep -Ev "^[ \t]*.+\.[^ ]" $filename | grep -Ec "^[ \t]*.+\." | sed -n -e 's/^\([0-9]\+\).*/\1/p')
        echo "There are $sentences sentences in $filename" > "$output_dir/results.txt"
    fi

# include: "^[ \t]*.+\."
# don't include: "^[ \t]*.+\.[^ ]" e.g. "15.0"