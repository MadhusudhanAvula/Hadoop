def largestRectangle(hist):
    stack=[]
    max_area=0
    i = 0
    while i < len(hist): 
        if (not stack) or (hist[stack[-1]] <= hist[i]):
            stack.append(i)
            i+=1
        else:
            top_of_stack=stack.pop()
            area=(hist[top_of_stack] * ((i - stack[-1] -1 ) if stack else i))
            max_area=max(max_area,area)

    while stack:
        top_of_stack=stack.pop()
        area=(hist[top_of_stack] * ((i - stack[-1] -1 ) if stack else i))
        max_area=max(max_area,area)
    return max_area
    
    hist = [6, 2, 5, 4, 5, 1, 6]
    print(largestRectangle(hist))
