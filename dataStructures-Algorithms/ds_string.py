###https://hackernoon.com/50-data-structure-and-algorithms-interview-questions-for-programmers-b4b1ac61f5b0
###http://www.java67.com/2018/06/data-structure-and-algorithm-interview-questions-programmers.html
#https://stackoverflow.com/questions/25706136/efficiently-find-repeated-characters-in-a-string/25706298
# Find duplicate integer in a given list
def dup(ele):
    seen = set()
    li = list()
    for x in ele:
        if x not in seen:
            seen.add(x)
        else:
            li.append(x)
    return li
print(dup([1,2,3,4,5,6,7,8,9,10,1,2,3,4,5]))

#Return list of items in list greater than some value
>>> from timeit import timeit
>>> timeit(lambda: [i for i in j if i >= 5]) # Michael Mrozek
1.4558496298222325
>>> timeit(lambda: filter(lambda x: x >= 5, j)) # Justin Ardini
0.693048732089828
>>> timeit(lambda: filter((5).__le__, j)) # Mine
0.714461565831428

#Counting repeated characters in a string in Python
# http://www.java67.com/2014/03/how-to-find-duplicate-characters-in-String-Java-program.html --In Java
s = 'Programming'
dic={}
for c in s:
    if c in dic:
        dic[c]+=1
    else:
        dic[c] = 1
out={(k, v) for k, v in dic.items() if v > 1}
print(out)

# function to check if two strings are anagram or not 
def check(s1, s2): 
    if s1.__len__() != s2.__len__():
        print("The strings length are not matching. So strings aren't anagrams")
        # the sorted strings are checked 
    else:
        if(sorted(s1)== sorted(s2)): 
            print("The strings are anagrams.") 
        else: 
            print("The strings aren't anagrams.")
                      
# driver code 
s1 ="listen"
s2 ="silent"
check(s1, s2)

###Python Program to Reverse a String Using Recursion
def reverse(ele):
    print(ele)
    if len(ele) == 0:
        return ele
    else:
        return reverse(ele[1:]) + ele[0]

#print(reverse("avula"))

def reversenew(ele):
    st=''
    if len(ele) != 0:
        #print(ele)
        for c in reversed(ele):
            st+=c
        return st
    else:
        return st

print(reversenew("madhu"))
### To reverse a word in a sentense
s = "i like this program very much"
words = s.split(' ') 
string =[] 
for word in words: 
    string.insert(0, word) 
    print(word)
  
print("Reversed String:") 
print(" ".join(string)) 

# Another way to reverse a word in a sentense
a = "The quick brown fox jumped over the lazy dog."
b = a[::-1]
print b
Results:
.god yzal eht revo depmuj xof nworb kciuq ehT
#
" ".join(a.split()[::-1])

###check if a Python string contains only digits
import re
print(bool(re.match('^[0-9]+$', '123abc')))
print (bool(re.match('^[0-9\.\ ]+$', '123.123')))

###Program to count occurrence of a given character in a string
def con(s,c):
    res=0
    for i in range(len(s)):
        if (s[i].lower() == c):
            res=res+1
    return res

###Finding all possible permutations of a given string in python
from itertools import permutations
perms = [''.join(p) for p in permutations('stack')]
print(perms)

print(con("AvulaMadhusudhan","a"))

# Second Method to count occurrence of a given character in a string using recurssion
def removeCharFromStr(str, index):
    endIndex = index if index == len(str) else index + 1
    print("endindex----", endIndex)
    print("removeCharFromStr Print", str[:index], "+++++" , str[endIndex:])
    return str[:index] + str[endIndex:]


def perm(str):
    if len(str) <= 1:
        return {str}
    permSet = set()
    for i, c in enumerate(str):
        print(i,c)
        newStr = removeCharFromStr(str, i)
        print("newStr ----", newStr)
        retSet = perm(newStr)
        print("retSet ----", retSet)
        for elem in retSet:
            permSet.add(c + elem)
    return permSet

print(perm("avula"))

###Find the 1st and 2nd Min value in a list/array 
def minimum(arr):
    min=arr[0]
    min2=arr[1]
    #print("min value before func",min)
    for i in range(len(arr)):
        if arr[i] < min:
            min2 = min
            min = arr[i]
            print("minimum value",min)
            print("second minimum value",min2)
        

arr=[2,3,0,6]
minimum(arr)
    

