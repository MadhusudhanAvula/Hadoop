###https://github.com/vprusso/youtube_tutorials/blob/master/algorithms/search_algorithms/binary_search/binary_search.py
# Linear Search
def linear_search(data, target):	
	for i in range(len(data)):
		if data[i] == target:
			return True
	return False

# Iterative Binary Search 
def binarySearchIterative(arr,key):
    low=0
    high=len(arr)-1
    while low <= high:
        mid=(low+high)//2
        if key == arr[mid]:
            print("Found value {} at {} position".format(arr[mid],mid))
            return mid
        elif key < arr[mid]:
            high=mid-1
        elif key > arr[mid]:
            low=mid+1
    else:
        print("Element is not present in the array ")
    
    
arr = [2,4,5,7,8,9,12,14,17,19,22,25,27,28,33,37]
key = 88
print(binarySearchIterative(arr, key))

# Recursive Binary Search 
def binarySearchRecursive(arr,key,low,high):
    if high >= low:
        mid =(low+high)//2
        if key == arr[mid]:
            print("Found value {} at {} position".format(arr[mid],mid))
        elif key < arr[mid]:
            return binarySearchRecursive(arr, key,low,mid -1)
        elif key > arr[mid]:
            return binarySearchRecursive(arr, key, mid+1, high)
    else:
        print("Element is not present in the array ")
            
arr = [2,4,5,7,8,9,12,14,17,19,22,25,27,28,33,37]
key = 37
print(binarySearchRecursive(arr, key,0,len(arr)-1))
