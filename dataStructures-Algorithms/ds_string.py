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

### Find kthe smallest or largest in an array.
def klargestNumber(arr,k):
    arr.sort(reverse=True)
    for i in range(k):
        print(arr[i])
        
        
arr = [1, 23, 12, 9, 30, 2, 50] 
k = 3
klargestNumber(arr, k)   

### Find the next greatest element in a array
def nge(arr):
    for i in range(0,len(arr)):
        ne =-1
        for j in range(i+1, len(arr)):
            if arr[i] < arr[j]:
                ne=arr[j]
                break
        print(arr[i], "===>",ne)

nge(arr)

### Indeed question
arr=["a","b","c","a","b","a","a","b","c","a"]
final_list=[]
def uniqlist(arr):
    while arr:
        in_list=list(set(arr))
        final_list.append(list(in_list))
        for items in in_list:
            arr.remove(items)
        uniqlist(arr)
    return final_list
        
    print(final_list)
    #new_arr=[subvalues for subvalues in arr if items not in final_list ]
    print(arr)
      
#print(uniqlist(arr))

## VISA --> FIND HOW MANY TIMES STRING IS PRESENT IN INPUT
def sockMerchant(arr):
    count=0
    sub=['p','c','m','z','b']
    d={}
    p=c=m=z=b=0
    for i in range(len(arr)):
            if arr[i]=='p':
                p+=1
            if arr[i]=='c':
                c+=1
            if arr[i]=='m':
                m+=1
            if arr[i]=='z':
                z+=1
            if arr[i]=='b':
                b+=1
    return min(p,c,m,z,b)     


if __name__ == '__main__':
    
    #ar = list(map(int, input().rstrip().split()))
    
    #ar=list(input())
    ar=list("pcmzbpppcaamrzibpcmbz")
    print(ar)

    result = sockMerchant(ar)
    print(result)
    
"""Rotate nxn matrix by 90 degrees"""
def rotate(matrix):
    if matrix is None or len(matrix)<1:
        return
    else:
        if len(matrix)==1:
            return matrix
        else:
            #solution matrix
            soln = [row[:] for row in matrix]
            #size of matrix
            m = len(matrix[0])
                    
            for x in range(0,m):
                for j in range(0,m):
                    soln[j][m-1-x] = matrix[x][j]
            return soln

if __name__=="__main__":
    six = [["a","b","c"],
          [1,2,3],
          ["x","y","z"]]
    print ("%s" % rotate(six))
