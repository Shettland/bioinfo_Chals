#!/bin/bash


fastafile=$1

restriction=$2

args=($1 $2)

if [[ ${#args[@]} < 2 ]];
then
	echo "some or all the arguments are missing"
	exit 1
fi

echo -e "${#args[@]} arguments selected: ${args[@]}"

if [[ -f tempfile.txt ]];
then
	rm tempfile.txt
fi

if [[ -f result.txt ]];
then
	rm result.txt
fi

#working with fasta file
touch tempfile.txt

rmlines=$(cat ${fastafile} | grep -v ">" | tr -d "\n" > tempfile.txt)

restr=$(sed -i "s/${restriction}/\n/g" tempfile.txt)

for (( i=1 ; i<4 ; i++ ));
do
	counter=$(sed -n "${i}p" tempfile.txt | wc -c)
	frag=$(sed -n "${i}p" tempfile.txt| sed "s/^/>fragment_${i}_${counter}\n/g")
	appender=$(echo -e "$frag" >> result.txt)
done

rm tempfile.txt
