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
