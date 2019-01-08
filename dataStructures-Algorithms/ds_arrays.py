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

###
