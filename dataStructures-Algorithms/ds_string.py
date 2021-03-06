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

###Find the Missing Number in a sorted array
def getMissingNo(A): 
    n = len(A) 
    print(n)
    total = (n+1)*(n+2)/2
    print(total)
    sum_of_A = sum(A) 
    print(sum_of_A)
    return total - sum_of_A 

A = [1, 2, 4, 5, 6] 
miss = getMissingNo(A) 
print(miss) 

###Search an element in an array where difference between adjacent elements is 1 -- Amazon telephonic interview question
#https://www.geeksforgeeks.org/search-an-element-in-an-array-where-difference-between-adjacent-elements-is-1/
#Given an array where difference between adjacent elements is 1, write an algorithm to search for an element in the array and return the position of the element (return the first occurrence).
def search(arr,x):
    n=len(arr)
    i=0
    while(i<n):
        if (arr[i] == x):
            return i
        i=i+abs(arr[i]-x)
        print("I at the end of if loop",i)
    print("Number is not present in Arr")
    return -1

arr = [8 ,7, 6, 7, 6, 5, 4, 3, 2, 3, 4, 3, 2, 1 ] 
x=1
print("Element is present at",search(arr,x))


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
    
#1249. Minimum Remove to Make Valid Parentheses -- Facebook
 class Solution:
    def minRemoveToMakeValid(self, s: str) -> str:
        closed = s.count(")")
        opened = 0
        result = ""
        for ele in s:
            if ele == "(":
                if closed == 0:
                    continue
                else:
                    opened +=1
                    closed -=1
            if ele == ")":
                if opened == 0:
                    closed -=1
                    continue
                else:
                    opened -=1
            result += ele
        return result
sol = Solution()
print(sol.minRemoveToMakeValid("lee(t(c)o)de)"))

# Google::: Given a string pattern of 0s, 1s , and ?s (wildcards), generate all 0-1 strings that match this pattern. e.g. 1?00?101 -&gt; [10000101, 10001101, 11000101, 11001101]. You can generate the strings in any order that suits you.
str="1??0?101"
result=[]
def binStr(str):
    if "?" in str:
        s1 = str.replace("?",'0',1)
        s2 = str.replace("?",'1',1)
        binStr(s1)
        binStr(s2)
    else: result.append(str)
    return result

print(binStr(str))

#283. Move Zeroes --> Facebook
class Solution:
    def moveZeroes(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        for ele in nums:
            print(ele)
            if ele == 0:
                nums.remove(ele)
                nums.append(ele)
        return nums
   
#884. Uncommon Words from Two Sentences
class Solution:
    def uncommonFromSentences(self, A: str, B: str) -> List[str]:
        dict={}
        def toDict(lst):
            for ele in lst.split(" "):
                if ele not in dict:
                    dict[ele] =1
                else:
                    dict[ele] +=1
        toDict(A)
        toDict(B)
        print(dict)
        return [k for k,v in dict.items() if v == 1]
#Input: A = "this apple is sweet", B = "this apple is sour", Output: ["sweet","sour"]

#66. Plus One
class Solution:
    def plusOne(self, digits: List[int]) -> List[int]:
        if len(digits) == 0:
            return [1]

        if digits[-1] != 9:
            digits[-1] += 1
            return digits
        
        else:
            digits = self.plusOne(digits[:-1])
            digits.append(0)
            return digits
#Input: digits = [1,2,3], Output: [1,2,4]

#1. Two Sum
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        for i in range(len(nums)):
            for j in range(i+1, len(nums)):
                if nums[i] + nums[j] == target:
                    return [i,j]
#Input: nums = [2,7,11,15], target = 9, Output: [0,1], Output: Because nums[0] + nums[1] == 9, we return [0, 1].

#1396. Design Underground System -- bloomberg
class UndergroundSystem:

    def __init__(self):
        self.check_in={}
        self.trip=defaultdict(list)
        
    def checkIn(self, id: int, stationName: str, t: int) -> None:
        self.check_in[id] = (stationName, t)
        
    def checkOut(self, id: int, stationName: str, t: int) -> None:
        checkInStation, checkInTime = self.check_in[id]
        self.trip[(checkInStation, stationName)].append(t-checkInTime)
        
    def getAverageTime(self, startStation: str, endStation: str) -> float:
        trips = self.trip[(startStation, endStation)]
        return sum(trips)/len(trips) 


# Your UndergroundSystem object will be instantiated and called as such:
# obj = UndergroundSystem()
# obj.checkIn(id,stationName,t)
# obj.checkOut(id,stationName,t)
# param_3 = obj.getAverageTime(startStation,endStation)

#Input ["UndergroundSystem","checkIn","checkIn","checkIn","checkOut","checkOut","checkOut","getAverageTime","getAverageTime","checkIn","getAverageTime","checkOut","getAverageTime"][[],[45,"Leyton",3],[32,"Paradise",8],[27,"Leyton",10],[45,"Waterloo",15],[27,"Waterloo",20],[32,"Cambridge",22],["Paradise","Cambridge"],["Leyton","Waterloo"],[10,"Leyton",24],["Leyton","Waterloo"],[10,"Waterloo",38],["Leyton","Waterloo"]]

# Google::: Given a string pattern of 0s, 1s , and ?s (wildcards), generate all 0-1 strings that match this pattern. e.g. 1?00?101 -&gt; [10000101, 10001101, 11000101, 11001101]. You can generate the strings in any order that suits you.
str="1??0?101"
result=[]
def binStr(str):
    if "?" in str:
        s1 = str.replace("?",'0',1)
        s2 = str.replace("?",'1',1)
        binStr(s1)
        binStr(s2)
    else: result.append(str)
    return result

print(binStr(str))

#JPM::: Find the intersection of two arrays of integers.
A = [1,4,3,2,5,8,9]
B = [6,3,2,7,5]
for i in A:
    if i in B:
        print(i)

#union of two arrays
st = set()
for i in A:
    for j in B:
        if i not in st or j not in st:
            st.add(i)
            st.add(i)
print(st)

#https://leetcode.com/discuss/interview-question/760228/goldman-sachs-coderpad-interview-1st-round-data-engineer-2-year-exp-july-2020
#GS::: Given a 2-D String array of student-marks find the student with the highest average and output his average score. If the average is in decimals, floor it down to the nearest integer.
arr = [["Bob","80"], ["Bob","87"], ["Mike", "35"],["Bob", "52"], ["Jason","35"], ["Mike", "55"], ["Jessica", "99"]]
dict ={}
for ele in arr:
    if ele[0] in dict:
        dict[ele[0]] = (int(ele[1]) + int(dict[ele[0]]))/2
    else:
        dict[ele[0]] = int(ele[1])
print(max(dict.values()))

#GS::: Given a string like ‘UUUDULR’, need to derive the final coordinates starting from (0, 0). This is pretty easy and he is asked to add a few other test cases if I would like to.
str = "LLLUUUUURDDDXLLR"
out = [0,0]
for i in str:
    if i == "U":
        out[1] = out[1] + 1
    if i == "D":
        out[1] = out[1] - 1
    if i == "R":
        out[0] = out[0] + 1
    if i == "L":
        out[0] = out[0] - 1
print(out)

#JPM https://leetcode.com/problems/happy-number/
class Solution:
    def isHappy(self, n: int) -> bool:
        arr = []
        
        while n != 1:
            if n in arr: return False
            arr.append(n)
            n = sum([int(i)**2 for i in str(n)])
        
        return True
obj = Solution
obj.isHappy( 19)
#JPM Fibonacci Series - NOV 2020
#JPM Decode String or decoding numbers - NOV 2020

# isvalid parentheses
class Solution(object):
    def isValid(s):
        stack = []
        match = {'(': ')', '[': ']', '{': '}'}
        for c in s:
            if c in ['(', '[', '{']:
                stack.append(c)
            elif not stack or match[stack.pop()] != c:
                return False
            print(stack)
        return not stack

obj = Solution
obj.isValid( "([)]")

# https://leetcode.com/discuss/interview-experience/281149/facebook-data-engineer
# find the average length of word in sentence
# Validate the ip address
# FB May 2020 for a list array=[['D'],['A','B'],['A','C'],['C','A']] find the number of followers
d = dict()
for x in input_array:
    if x[0] not in d.keys():
        d[x[0]] = 1
    else:
        d[x[0]] += 1       
return d

input_arr = [['D'], ['A', 'B'], ['A', 'C'], ['C', 'A']]
print(find_followers(input_arr)) # -> {'D': 1, 'A': 2, 'C': 1}
