fibonacci_cache={}
def fibonacci(n):
    if type(n) != int:
        raise TypeError("n must be a positive INTEGER")
    if n<1:
        raise ValueError("n must be a positive INTEGER")
    if n in fibonacci_cache:
        print("cached fibonacci value in cache",n,":" ,fibonacci_cache[n])
        return fibonacci_cache[n]
    
    if n ==1:
        value =1
    elif n ==2:
        value =1
    elif n>2:
        value =fibonacci(n-1)+fibonacci(n-2)
    fibonacci_cache[n] = value
    return value

print(fibonacci(100))

#for n in range(1,n):
#   print(n, ":", fibonacci(n))
