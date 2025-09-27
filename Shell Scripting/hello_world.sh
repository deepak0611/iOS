#! /bin/bash


# Print something
echo "Hello world!"

# Define variables
firstname=Deepak
lastname=Singh

echo $firstname $lastname

# Read input from terminal & Arithmetic operations
echo "Enter first number"
read firstNumber

read -p "Enter Second Number" secondNumber  # syntax to take input with a prompt

sum=$((firstNumber+secondNumber)) # syntax for arithmetic operations
diff=$((firstNumber-secondNumber))
mul=$((firstNumber*secondNumber))
div=$((firstNumber/secondNumber))
mod=$((firstNumber%secondNumber))
echo $sum $diff $mul $div $mod


# Logical operators and conditional statements

if [ $firstNumber -eq $secondNumber] # use -ne for not equal to
then
echo "firstNumber equals secondNumber"
elif [ $firstNumber -gt $secondNumber] # use -ge for greater than equal to
then
echo "firstNumber is greater than secondNumber"
elif [ $firstNumber -lt $secondNumber] # use -le for less than equal to
then
echo "firstNumber is less than secondNumber"
fi

# And Or operator
read a
read b
read c

if [ $a == $b -a $b == $c -a $a == $c ] # -a represent AND operator
then
echo EQUILATERAL
elif [ $a == $b -o $b == $c -o $a == $c ] # -o represent OR operator
then
echo ISOSCELES
else
echo SCALENE
fi


# Looping

#for loop
for i in {1..5} # the loop will iterate 5 times
do
    echo $i
done

# iterating array
for X in cyan magenta yellow
do
    echo $X
done

# it will print
# cyan
# magenta
# yellow


# while loop
i=1
while [[ $i -le 10 ]] ; do
   echo "$i"
  (( i += 1 ))
done
# This will print number from 1 to 10.
