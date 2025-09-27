set -xe

mkdir my_project
cd my_project
git init
touch myFile.txt
echo "Hi">>myFile.txt

git add myFile.txt
git commit -m "init"
