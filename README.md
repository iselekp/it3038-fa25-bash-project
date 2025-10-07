This bash script is for IT 3038C, a UC course, and intended to demonstrate options and arguments, output, regex and file handling. Specifically, the script counts features of the input text file depending on option arguments. The script handles errors such as invalid options and a nonexistent text file. Use the -h option to display the usage in bash:
text_counter -f <filename> -o <output_dir> -t <type>

  Options:
    -f <filename>: Specify the input filename.
    -o <output_dir>: Specify the output directory where the results will be stored.
    -t <type>: Specify the type of action to perform. Supported types are 'line', 'word' and 'sentence'.
    -h: Display this help information.

The actions count the respective text features in the input file. 
