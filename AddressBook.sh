#! /bin/bash/ -x

echo "Welcome to Address book code"
flag=0

#OPEN ADDRESS BOOK FUNCTION
function openAddressBook()
{
	echo "Enter Address Book Name"
	read AddressBookName
	cat "$AddressBookName.txt"
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
	fileName="$AddressBookName.txt"
	echo -e "Fname\t Lname\t Address\t city\t state\t zip\t Phone_Number\t" >> $fileName
	read -p "Enter First name" fName
	read -p "Enter Last name" lName
	read -p "Enter Address" Address
	read -p "Enter city" city
	read -p "Enter State" state
	read -p "Enter zip" zip
	read -p "Enter Phone Number" phoneNumber
	echo -e "$fName\t $lName\t $Address\t $city\t $state\t $zip\t $phoneNumber\t" >> $fileName
	cat "$AddressBookName.txt"
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
