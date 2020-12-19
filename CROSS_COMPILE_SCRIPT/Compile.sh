#!/usr/bin/bash

## TRANSFER DATA FUNCTION ##
Transfer(){

	echo -e "\n\t** TRANSFERING **"
	
	user='test'
	password='test'
	
	if [[ $# == 3  ]] 
	then	
		ip=$1
		user=$2
		password=$3		
	else
		ip="192.168.0.12"
		user="pi"
		password="S*#rrQl*mA"
	fi
	
	echo $ip $user $password
	current=`pwd`
	folder=`basename "$current"`
	echo "$folder"
	
	scpCommand="$folder $user@$ip:/home/pi/Desktop"
	sshpass -p 'S*#rrQl*mA' scp $scpCommand
}



##  COMPILATION  FUNCTION ##
Compilation(){

	echo -e "\t******\tSTART\t******\n"
	echo -e "\t** COMPILATION **\n"
	echo "Changing directory to" $1 "..."
	cd $1
	
	echo "Executing qmake..."
	~/rpi/qt5.15/bin/qmake
	make
	
	Transfer $2 $3 $4
	echo -e "\n\t******\tEND\t******"
}



######### BEGIN OF MAIN #########
## LOGO ##
echo -e "\n***************************************************************"
echo -e "\t.: Welcome in the Lewy-Cross-Compile bash! :."
echo -e "***************************************************************\n"


## MENU ##
if [[ -z "$1" ]]
then	

## PARAMETER IS EMPTY ##
	echo Type -help to see a list of options. Leave empty to leave.
	echo ---------------------------------------------------------------
	echo
	read -p "Command: " option
	case "$option" in
	
	"-help")	
		echo -e "\nTo compile your project, please start this bash with the parameter"
		echo "First parameter -> path to the folder which contains your project"
		echo "Other options:"
		echo -e "\t -compile : Allows you to compile project and transfer the exec file to the Raspberry Pi\n";;
		
	"-compile")
		echo "Insert [path_to_folder] [Raspberry_IP] [Rasperry_User]:"
		read path ip user
		echo -n "Insert password for $user: "
		read password
		Compilation $path $ip $user $password
	 esac
	 
else

## PARAMETER IS FILLED - COMPILATION PROCESS ##
	case $1 in
	
		"-help")
			echo -e "THE RIGHT SCHEMA:"
			echo -e "source Compile [path_to_folder] [Raspberry_IP] [Rasperry_User] [Rasperry_User's_Password]\n"
			echo "MY VERSION:"
			echo "source Compile.sh ~/Desktop/Windows-Share/nienazwany1 192.168.0.12 pi S*#rrQl*mA";;
		
		*)
			if cd $1 
			then 	
				Compilation $1 $2 $3 $4
			else
				echo "! ! ! ! ! ! ! ! ! ! ! ! ! ! ! "
				echo "ERROR: Cannot find path $1"
				echo "ERROR: Try again with the correct path"
			fi;;
	esac
fi 

cd ~/Desktop/
#################################

