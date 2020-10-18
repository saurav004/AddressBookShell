#! /bin/bash/ -x

echo "Welcome to Address book code"
flag=0

#OPEN ADDRESS BOOK FUNCTION
function openAddressBook()
{
	echo "Enter Address Book Name"
	read AddressBookName
	cat "$AddressBookName.txt"
	echo -e "choose from options given"
	echo -e "1.\tadd an entry"
	echo -e "2.\tdelete an entry"
	echo -e "3.\tsearch an entry"
	echo -e "4.\tupdate an entry"
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
	* )
	echo "Invalid choice!!"
	;;
	esac
}

#CREATE ADDRESS BOOK CODE
function createAddressBook()
{
	read -p "Enter Address Book Name" AddressBookName
	if [ -f "$AddressBookName.txt" ]
		then
	echo	"file already exists"
	else
	touch "$AddressBookName.txt"
	echo "AddressBook $AddressBookName created!!"
	fi
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
   read -p "Enter Phone Number" phoneNumber
	alreadyExists=`cat $fileName | grep $phoneNumber | wc -c`
	if [ $alreadyExists -gt 0 ]
	then
	echo "entry already exists"
	else
	read -p "Enter First name" fName
   read -p "Enter Last name" lName
   read -p "Enter Address" Address
   read -p "Enter city" city
   read -p "Enter State" state
   read -p "Enter zip" zip
   echo -e "$fName\t $lName\t $Address\t $city\t $state\t $zip\t $phoneNumber\t" >> $fileName
   cat $fileName
   fi
}

#DELETE AN ENTRY

function deleteEntry(){

fileName="$AddressBookName.txt"
read -p "Enter your phone Number" phoneNumber
alreadyExists=`cat $fileName | grep $phoneNumber | wc -c`
    if [ $alreadyExists > 0 ]
	 then
		cat $fileName | grep -v $phoneNumber > $fileName
		echo "entry deleted"
		cat $fileName
	fi
}

#SEARCH AN ENTRY

function searchEntry(){
read -p "Enter phone Number" phoneNumber
ifExists=`cat "$AddressBookName.txt" | grep $phoneNumber | wc -c`
if [ $ifExists -gt 0 ]
	then cat "$AddressBookName.txt" | grep $phoneNumber
	else 
	echo "Entry doesn't exists"
fi
}

#update an Entry

function updateEntry(){
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
cat $fileName | grep -v $phoneNumber > $fileName
read -p "Enter First name" fName
   read -p "Enter Last name" lName
   read -p "Enter Address" Address
   read -p "Enter city" city
   read -p "Enter State" state
   read -p "Enter zip" zip
	echo -e "$fName\t $lName\t $Address\t $city\t $state\t $zip\t $phoneNumber\t" >> $fileName
   cat $fileName

}












while [ $flag == 0 ]
do
AddressBookNumbering=0
for file in `ls *.txt`
do
	((AddressBookNumbering++))
	AddressBook=`echo $file | awk -F. '{print$1}'`
	echo "$AddressBookNumbering$AddressBook"
done
echo "select the options from below"
echo "1.open an address book"
echo "2.create an Address book"
echo "3.delete an Address book"
echo "4.delete all Address Books"
echo "5.EXIT"
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
