#!/bin/bash

# leakcheck
# Bash script to check an email address or username against the haveibeenpwned.com database
# Results will be listed if an address or username has been included in a major data breach
# If results are found, then an option to save a results file with details of the breach will be displayed

# Keep in mind. Repeated use in a short period of time may trigger haveibeenpwned.com to ratelimit you.

echo  "Please enter an email address or username..."

read input
response=$(curl --write-out %{http_code} --silent --output /dev/null "https://haveibeenpwned.com/api/breachedaccount/$input")
echo " "
echo "Processing inputted data, please wait..."
echo " "

if [ "$response" = "404" ];then
    echo "Good news! No results found, address or username is not listed."

elif [ "$response" = "400" ];then
    echo "Error! No data could be returned from haveibeenpwned.com..." 
  
else
    temp=$(curl --silent --request GET "https://haveibeenpwned.com/api/breachedaccount/$input")
    echo  "That address/username is listed in the following known data breach(es):"
	echo  " "	
	echo  ""$temp""
	echo  " "    
	echo  "Do you want further details? (y/n)"
	echo  " "
    read ans
    if [ "$ans" = "y" ] || [ "$ans" = "Y" ] ;then
	curl --silent --request GET "https://haveibeenpwned.com/api/v2/breachedaccount/$input"|python -mjson.tool > $input.txt
	cat $input.txt|sed -e 's!http\(s\)\{0,1\}://[^[:space:]]*!!g' -e 's/[@#\$%^&*()=039"]//g' -e 's/<\/td>//g' -e 's/<em>//g' -e 's/<\/em>//g' -e 's/<a//g'  -e 's/<\/a>//g'  >  Breach_$input.txt
	cat Breach_$input.txt
	rm $input.txt

	echo " "
	echo "Further details saved into Breach_$input.txt file"
    fi

    if [ "$ans" = "n" ] || [ "$ans" = "N" ] ;then 	
	echo " "	
	echo "No details saved. Quitting..."	
	exit 1
    fi
	    
fi
