#!/bin/bash

        #Find statements function        
        function find_statements() {

        # To initialize array index counter
        i=0

        # Iterate for separation between periods. Read in array
        while IFS=. read -r -a line
        do
        IFS="."

                # Iterate each elements of array line
                for stat in ${line[@]}
                do

                        # Assigning element to array statements
                        statements[i]=$(echo $stat | sed 's/^ //g')

                        # Increment counter
                        i=$((i+1))
                done
        done < $1

        # Displaying  table title
        echo -e "\t\tWords\tletters"

        # Initilize  array counter
        i=1

        # Iterate over elements of statement
        for statement in ${statements[@]}
        do
                # Counting  number of words & letters
                words=$(echo $statement | wc -w)
                letters=$(echo $statement | tr -d ' ' | wc -c)

                # Displaying the words & letters count
                echo -e "Statement $i:\t  $words\t  $((letters-1))"

                # Increment the counter by 1
                i=$((i+1))
        done
}

        # Verifying if argument is passed
if(($#==1))
then
        # Setting file to $1
        file=$1
else
        # Prompting user for a file
        echo -n "Text file: "
        read file
fi

        # Verifying to see  if the file exists
if [ -f $file ]
then
        # Prompt to call the function
        find_statements $file
else
        # If no such file, display error text  and exit
        echo "$file: file not exist"
        exit 1
fi
