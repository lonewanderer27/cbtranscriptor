#!/bin/bash

##
#Camp Buddy Transcript Creator
#Jay
#2021
#
#All rights reserved to the creators of Camp Buddy.
#I do not own any of the transcripts that are created by this tool
#and shall not be liable for any criminal offenses.
#
#peace out.
##


# Bash Menu Script
PS3='Please enter your choice: '
options=("Keitaro" "Hiro" "Natsumi" "Yoichi" "Taiga")
select opt in "${options[@]}"
do
    case $opt in
        "Keitaro")
            echo "you chose Keitaro transcript"
            break
            ;;
        "Hiro")
            echo "you chose Hiro transcript"
            break
            ;;
        "Natsumi")
            echo "you chose Natsumi transcript"
            break
            ;;
        "Yoichi")
            echo "you chose Yoichi transcript"
            break
            ;;
        "Taiga")
            echo "you chose Taiga transcript"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


rm -f ./about.rpy
rm -f ./crack_gallery.rpy
rm -f ./credits.rpy
sleep 3
echo "Determing what files to delete"
sleep 3
echo "..."
sleep 2
echo ".."


if  [[ $REPLY == 1 ]];
    then
        character=Keitaro
        rm -rf ./"$character"
        mkdir ./"$character"
        for filename in *.rpy; do
            #echo "Trimming ""$filename"
            grep -F 'k "' "$filename" > tmp"$character""$filename" #for every file that ends with .rpy extension, only copy the lines that starts with 'k "'
            #exclusive for Keitaro
        done

elif [[ $REPLY == 2 ]];
    then
        character=Hiro
        rm -rf ./"$character"
        mkdir ./"$character"
        for filename in *.rpy; do
            #echo "Trimming ""$filename"
            grep -F 'hi "' "$filename" > tmp"$character""$filename" #for every file that ends with .rpy extension, only copy the lines that starts with 'hi "'
            #exclusive for Hiro
        done

elif [[ $REPLY == 3 ]];
    then
        character=Natsumi
        rm -rf ./"$character"
        mkdir ./"$character"
        for filename in *.rpy; do
            #echo "Trimming ""$filename"
            grep -F 'n "' "$filename" > tmp"$character""$filename" #for every file that ends with .rpy extension, only copy the lines that starts with 'n "'
            #exclusive for Natsumi
        done
        
elif [[ $REPLY == 4 ]];
    then
        character=Yoichi
        rm -rf ./"$character"
        mkdir ./"$character"
        for filename in *.rpy; do
            #echo "Trimming ""$filename"
            grep -F 'yi "' "$filename" > tmp"$character""$filename" #for every file that ends with .rpy extension, only copy the lines that starts with 'yi "'
            #exclusive for Yoichi
        done
elif [[ $REPLY == 5 ]];
    then
        character=Taiga
        rm -rf ./"$character"
        mkdir ./"$character"
        for filename in *.rpy; do
            #echo "Trimming ""$filename"
            grep -F 't "' "$filename" > tmp"$character""$filename" #for every file that ends with .rpy extension, only copy the lines that starts with 't "'
            #exclusive for Taiga
        done
else
   echo "Invalid answer!"

fi


        for filename in tmp"$character"*.rpy; do
            #echo "Removing unneeded lines..."                           
            sed -i 's/^[^"]*"\([^"]*\)".*/\1/' "$filename"              #extracts their dialogs
            sed -i "s/^[ \t]*//"  "$filename"                           #removes all the leading whitespaces
            sed -i 's/^"\(.*\)".*/\1/' "$filename"                      #removes the double quotes and everything that came before it and after
            sed -i ':start s/*[^>]*\*//g; /</ {N; b start}' "$filename" #removes "*" and "*" and everything in between them. AKA the s*x scenes hahaha
            sed -i ':start s/{[^>]*}//g; /</ {N; b start}' "$filename"  #cleans the {i}
            sed -i '/^$/d' "$filename"                                  #removes blank lines
        done



echo "Done extracting dialogs. Now copying:"

for filename in tmp"$character"*.rpy; do
    cp "$filename" ./"$character"/
done


for f in ./"$character"/tmp*.rpy; do
    mv -- "$f" "${f/tmp/}"                  #renames files. Opts out the tmp from the name.
done


for filename in tmp*.rpy; do    
    rm -r ./"$filename"                        #cleans up temporary files on the root folder
done

echo "Merging..."
cat ./"$character"/*.rpy >> ./"$character"/merged"$character".txt


for filename in ./"$character"/"$character"*.rpy; do    
    rm -r ./"$filename"                        #cleans up temporary files inside the character's folder
done

#Conversion to CSV preparation
sed -i -e "s/^/$character\:/" ./"$character"/merged"$character".txt    #inserts '<charactername>:' in every line. This is to prepare for csv conversion...
sed -i '1s/^/name:line\n/' ./"$character"/merged"$character".txt
mv ./"$character"/merged"$character".txt ./"$character"/merged"$character".csv      #renames file to csv

echo "Done! The resulting file is in " /"$character"/merged"$character".csv
