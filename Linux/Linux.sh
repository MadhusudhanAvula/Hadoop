7 = 4+2+1 (read/write/execute)
6 = 4+2 (read/write)
5 = 4+1 (read/execute)
4 = 4 (read)
3 = 2+1 (write/execute)
2 = 2 (write)
1 = 1 (execute)
find / -name "mysql*.jar" --> to search 
ln -s /root/hdp/java/mysql-commector/version(1.5.8.9) /root/hdp/mysql-connector --> to setup a soft link ln -s /orginal_path  /custome_name
unlink custome_name --> to unlink the path
ps -ef|grep -i manager(or)node | ps -fu hdfs(or)yarn  |  /hadoop dfsadmin -report |fsck
hadoop fs -du -s -h --> to find the size of file
ls -al

sudo lsof -u username | grep 'Book.scala'  --- to check file was open or not in linux

SCP:
scp avula@hostname:/path/file.dat avula@hostnaem:/path/

find /dv/data/ve2/bdf/rawz/phi/gbd/r000/inbound/ -type f | while read filename; do ll $filename; done
date:
$(date -d "${CURRENT_DT}" +%s%3N)  --> convert timestamp to 13 bytes epoch time
sed:
sed -e 's/\.[^\.]*$//' -e "s/_hist$//"`  --> REMOVING EXTENSION AFTER LAST . AND _HIST
sed 's/^[^_]*_//g' | sed -e 's/\_[^\_]*$//'  --> REMOVES STRING BEFORE FIRST _ AND AFTER LAST _

D="<>"   #Multi Character Delimiter
string="abcd<>efgh<>ijkl<>mn op<>qr st<>uv wx<>yz"  String with delimiters

#Split the String into Substrings
sList=($(echo $string | sed -e 's/'"$D"'/\n/g' | while read line; do echo $line | sed 's/[\t ]/'"$D"'/g'; done))
for (( i = 0; i < ${#sList[@]}; i++ )); do
  sList[i]=$(echo ${sList[i]} | sed 's/'"$D"'/ /')
done

echo 'aaa,"hell world, test text",bbb,ccc," test text"' | sed 's/,\("[^"]*"\)*/\n\1/g' --> conver , to /n
aaa
"hell world, test text"
bbb
ccc
" test text"

sed -e 's/'"${del}"'/\n/g' | sed -e "${num}q;d"


grep:
I find that grep -c '^' is significantly faster than grep -c '$'. to find row count in a file.
grep -i ^delimiter*`
ifconfig |grep -o -P '(?<=addr:).*(?= Bcast:)'

awk:
cat clm_edi_clm_hdr_hist.hql | awk 'BEGIN{FS="="};{print $1}'  --> to find string before =
echo "arg1=|+a&arg2=|+b&arg3=|+c" | awk 'BEGIN{FS="[=|+]+"};{print $2}'  -->
echo "arg1=|+a&arg2=|+b&arg3=|+c" | awk -v n=$abc 'BEGIN{FS="[=|+]+"} {print $n}'

echo "arg1=|+a&arg2=|+b&arg3=|+c" | awk -v FS="[$del]+" '{print $2}' --> working 
echo "arg1=|+a&arg2=|+b&arg3=|+c" | awk -v b=$num '{print $b}' FS="[$del]+" --> working good to goo..
echo "arg1=|+a&arg2=|+b&arg3=|+c" | awk -v n=$num '{print $n}' FS="[$del]+"--> good to go
echo "arg1=|+a&arg2=|+b&arg3=|+c" | awk -v n=$abc '{print $n}; BEGIN{FS="[=|+]+"}'---> working   ****2307****


awk -F 'ABCD' '{print $1 FS "."}' file


ll:
find ./atom/scala/ ! -regex '.*/[0-9]+\.html' --> find files without numbers in the fileNames
find ./atom/scala/ ! -name '*abc*' --> find files with the string 'abc'

Find:
## Drop files recursively
find ${Backup}/${SRC_CD^^}* -maxdepth 1 -type f  -mtime +30 -exec rm -f {} \; -print
touch -a -m -t 201903181205.09 tgs.txt  --> modify file date
find /path/to/base/dir/* -type d -ctime +10 -exec rm -rf {} \;
Explanation:
find: the unix command for finding files / directories / links etc.
/path/to/base/dir: the directory to start your search in.
-type d: only find directories
-ctime +10: only consider the ones with modification time older than 10 days
-exec ... \;: for each such result found, do the following command in ...
rm -rf {}: recursively force remove the directory; the {} part is where the find result gets substituted into from the previous part.

## Move or Copy file 
-maxdepth 0 means do not search directories or subdirectories. Instead only look for a matching file among those explicitly listed on the command line.
find . -maxdepth 1 -type f | xargs -I {} mv {} /etc/apache2/sites-available/

## Finding the Top 5 Big Files
find . -type f -exec ls -s {} \; | sort -n -r | head -5

