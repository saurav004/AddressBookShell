#! /bin/bash/ -x

echo "Welcome to Address book code"
flag=0
function openAddressBook()
{
	echo "Enter Address Book Name"
	read AddressBookName
	cat "$AddressBookName.txt"
}

function createAddressBook()
{
	read -p "Enter Address Book Name" AddressBookName
	if [ -f $AddressBookName ]
		then
		"file already exists"
	fi
	else 
	touch "$AddressBookName.txt"
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
	DeleteAddressBook
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
