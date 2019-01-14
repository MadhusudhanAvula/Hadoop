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
