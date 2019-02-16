###https://tutorialedge.net/compsci/sorting/selection-sort-in-python/
#http://bigocheatsheet.com/
# Bubble Sort In Python
# Performance Complexity = O(n^2)
# Space Complexity = O(n)
def bubbleSort(arr):
    swapped=True
    while swapped:
        swapped = False
        for i in range(len(arr)-1):
            if arr[i] > arr[i+1]:
                arr[i],arr[i+1] = arr[i+1],arr[i]
                print("swapped: {} with {}".format(arr[i],arr[i+1]))
                swapped=True
    return arr

my_list = [8,2,1,3,5,4]
print(bubbleSort(my_list))

###Selection Sort in Python
def selectionSort(arr):
    for position in range(len(arr)):
        mid=position
        for i in range(position+1,len(arr)):
            if arr[i] < arr[mid]:
                mid=i
        arr[position], arr[mid] = arr[mid], arr[position]
                
    print(arr)
    
my_array = [5,3,9,2,6,7,4]
selectionSort(my_array)

# Insertion Sort In Python 
# Performance Complexity = O(n^2)
# Space Complexity = O(n)
def insertionSort(my_list):
    # for every element in our array
    for index in range(1, len(my_list)):
        current = my_list[index]
        position = index

        while position > 0 and my_list[position-1] > current:
            print("Swapped {} for {}".format(my_list[position], my_list[position-1]))
            my_list[position] = my_list[position-1]
            print(my_list)
            position -= 1
        my_list[position] = current
    return my_list

my_list = [8,2,1,3,5,4]

print(insertionSort(my_list))

### Merge Sort
# Performance Complexity = O(nlogn)
# Space Complexity = O(n)
def mergeSort(arr):
    if len(arr)>1:
        mid=len(arr)//2
        left=arr[:mid]
        right=arr[mid:]  
        mergeSort(left)
        mergeSort(right)
        i=j=k=0
        while i < len(left) and j < len(right):
            if left[i] < right[j]:
                arr[k]=left[i]
                i+=1
            else:
                arr[k]=right[j]
                j+=1
            k+=1
    
        while i < len(left):
            arr[k]=left[i]
            i+=1
            k+=1
        while j < len(right):
            arr[k]=right[j]
            j+=1
            k+=1
        
# Code to print the list 
def printList(arr): 
    for i in range(len(arr)):         
        print(arr[i],end=" ") 
    print() 
  
# driver code to test the above code 
if __name__ == '__main__': 
    arr = [12, 11, 13, 5, 6, 7]  
    print ("Given array is", end="\n")  
    printList(arr) 
    mergeSort(arr) 
    print("Sorted array is: ", end="\n") 
    printList(arr) 
