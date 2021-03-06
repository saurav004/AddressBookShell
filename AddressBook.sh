#! /bin/bash/ -x
shopt -s extglob
isUpdate=0
echo "Welcome to Address book code"
flag=0

#OPEN ADDRESS BOOK FUNCTION

function openAddressBook()
{
		end=0
		echo "Enter Address Book Name"
		read AddressBookName
	if [ -f "$AddressBookName.txt" ]
	then
		while [ $end == 0 ]
		do
		cat "$AddressBookName.txt"
		echo -e "choose from options given"
		echo -e "1.\tadd an entry"
		echo -e "2.\tdelete an entry"
		echo -e "3.\tsearch an entry"
		echo -e "4.\tupdate an entry"
		echo -e "5.\tEXIT"
		read option3
		case $option3 in
			1 )
				addEntry
			;;
			2 )
				deleteEntry
			;;
			3 )
				searchEntry
			;;
			4 )
				updateEntry
			;;
			5 )
				end=1
			;;
			* )
				echo "Invalid choice!!"
			;;
		esac
	done
	else
			echo "Address Book Not found"
	fi
}

#CREATE ADDRESS BOOK

function createAddressBook()
{
	end=0
	yesno=0
	while [ $end == 0 ]
	do
		read -p "Enter Address Book Name" AddressBookName
		fileName="$AddressBookName.txt"
		if [ -f "$AddressBookName.txt" ]
			then
				echo	"file already exists"
		else
			touch "$AddressBookName.txt"
			echo "AddressBook $AddressBookName created!!"
		echo -e "First Name\t Last Name\t Address\t City\t State\t Zip\t Phone Number\t" >> $fileName
		fi
		echo "want to EXIT 1.yes 2.no"
		read yesno
		if [ $yesno == 1 ]
		then
		end=1
		fi
	done
}

#DELETE ADDRESS BOOK CODE

function deleteAddressBook(){
	flag1=0
	while [ $flag1 == 0 ]
	do
		read -p "enter address book name" AddressBookName
		if [ -f "$AddressBookName.txt" ]
		then
			rm "$AddressBookName.txt"
			echo "$AddressBookName deleted"
		else
			echo "file doesn't exists input valid name"
		fi
		read -p "wanna exit this window 1.yes 2.no" option1

		if [ $option1 == 1 ]
		then
			flag1=1
		fi
	done
}

#DELETE ALL ADDRESS BOOK CODE

function deleteAllAddressBooks(){

	for file in `ls *.txt`
	do
		rm $file
	done
}


#ADD An Entry in address book

function addEntry(){
fileName="$AddressBookName.txt"
patFnameLname="^[A-Z]{1}[a-z]{2,30}$"
patEmail="^[a-zA-Z][a-zA-Z0-9_\-+]*[.]{0,1}[a-zA-Z0-9_\-+]{1,}[@][a-zA-Z0-9]{1,}[.][a-zA-Z]{2,}[.]{0,}[a-zA-Z]*$"
patMobileNumber="^[+]{1}[0-9]{2}[ ][0-9]{10}"
patAddress="^[A-Za-z0-9'\.\-\s\,]{10,200}$"
patCity="^[A-Z]{1}[a-z]{2,50}$"
patState="^[A-Z]{1}[a-z]{2,50}"
patZip="^[1-9]{1}[0-9]{2}[ ]{0,1}[0-9]{3}$"
loop1=0
loop2=0
loop3=0
loop4=0
loop5=0
loop6=0
loop7=0
while [ $loop1 == 0  ]
do
	if [ $isUpdate == 0 ]
	then
	read -p "Enter Phone Number" phoneNumber
	fi
	if [[ $phoneNumber =~ $patMobileNumber ]]
	then
		loop1=1
	else
	echo "Innvalid!!"
	fi
done
	searchNumber=`echo $phoneNumber | awk '{print $2}'`
	alreadyExists=`cat $fileName | grep $searchNumber | wc -c`

	if [ $alreadyExists -gt 0 ]
	then
		echo "entry already exists"
	else
		while [ $loop2 == 0 ]
		do
			read -p "Enter First name" fName
			if [[ $fName =~ $patFnameLname ]]
    		then
    			loop2=1
			else
				echo "Invalid"
    		fi
		done

		while [ $loop3 == 0 ]
		do
 			read -p "Enter Last name" lName
			if [[ $lName =~ $patFnameLname ]]
    		then
    			loop3=1
    		else
				echo "Invalid"
			fi
		done

		while [ $loop4 == 0 ]
		do
   		read -p "Enter Address" Address
			if [[ $Address =~ $patAddress ]]
    		then
    			loop4=1
    		else
				echo "Invalid"
			fi
		done

   	while [ $loop5 == 0 ]
		do
 			read -p "Enter city" city
			if [[ $city =~ $patCity ]]
    		then
    			loop5=1
    		else
				echo "Invalid"
			fi
		done

		while [ $loop6 == 0 ]
		do
			read -p "Enter State" state
			if [[ $state =~ $patState ]]
    		then
    			loop6=1
    		else
				echo "Invalid"
			fi
		done

		while [ $loop7 == 0 ]
		do
   		read -p "Enter zip" zip
			if [[ $zip =~ $patZip ]]
   		 then
    			loop7=1
			else
				echo "Invalid"
			fi
		done
		echo -e "$fName\t $lName\t $Address\t $city\t $state\t $zip\t $phoneNumber\t" >> $fileName
   	cat $fileName
	fi
	isUpdate=0
}

#DELETE AN ENTRY

function deleteEntry(){

fileName="$AddressBookName.txt"
read -p "Enter your phone Number" phoneNumber
	alreadyExists=0
   searchNumber=`echo $phoneNumber | awk '{print $2}'`
   alreadyExists=`cat $fileName | grep $searchNumber | wc -c`
	 if [ $alreadyExists -gt 0 ]
	 then
		cat $fileName | grep -v $searchNumber > tmpfile && mv tmpfile $fileName
		echo "entry deleted"
		cat $fileName
	else
		echo "not found!!"
	fi
}

#SEARCH AN ENTRY

function searchEntry(){
	ifExists=0
	fileName="$AddressBookName.txt"
	read -p "Enter phone Number" phoneNumber
	searchNumber=`echo $phoneNumber | awk '{print $2}'`
   ifExists=`cat $fileName | grep $searchNumber | wc -c`
	if [ $ifExists -gt 0 ]
	then
		cat $fileName | grep $searchNumber
	else
		echo "Entry doesn't exists"
	fi
}

#update an Entry

function updateEntry(){
isUpdate=1
read -p "Enter phone number of the entry you want to update" phoneNumber
#echo "what do want to update"
#echo "choose from below"
#echo "1.First Name"
#echo "2.Last Name"
#echo "3.Address"
#echo "4.city"
#echo "5.state"
#echo "6.zip"
#read option4

fileName="$AddressBookName.txt"
#case $option4 in
#1 )
#read -p "Enter new first name" fName
#echo "$fName"
#fName=`cat "$fileName" | grep "$phoneNumber" | awk '{ $1 = $fName; print }'`
#;;
#2 )
#read -p "Enter new Last name" lName
#;;
#3 )
#read -p "Enter new Address" Address
#;;
#4 )
#read -p "Enter new city name" city
#;;
#5 )
#read -p "Enter new state name" state
#;;
#6 )
#read -p "Enter new zip" zip
#;;
#* )
#echo "Invalid choice!!"
#;;
#esac
ifExists=0
searchNumber=`echo $phoneNumber | awk '{print $2}'`
   ifExists=`cat $fileName | grep $searchNumber | wc -c`
	if [ $ifExists -gt 0 ]
	then
	cat $fileName | grep -v $searchNumber > tmpfile && mv tmpfile $fileName
	addEntry
	else
	echo  "Not found"
	fi
}

#Works like Main Menu
while [ $flag == 0 ]
do
AddressBookNumbering=0
for file in `ls *.txt`
do
	((AddressBookNumbering++))
	AddressBook=`echo $file | awk -F. '{print$1}'`
	echo -e "\t$AddressBookNumbering\t$AddressBook"
done
echo -e "select the options from below"
echo -e "\t 1.\topen an address book"
echo -e "\t 2.\tcreate an Address book"
echo -e "\t 3.\tdelete an Address book"
echo -e "\t 4.\tdelete all Address Books"
echo -e "\t 5.\tEXIT"
read option
case $option in
	1 )
	openAddressBook
	;;
	2 )
	createAddressBook
	;;
	3 )
	deleteAddressBook
	;;
	4 )
	deleteAllAddressBooks
	;;
	5 )
	flag=1
	;;
	* )
	echo "invalid choice"
	;;
esac
done
