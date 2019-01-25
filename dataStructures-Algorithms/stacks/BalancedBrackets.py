def isBalanced(s):
    stack=[]
    for symbol in s:
        if symbol == '[' or symbol == '{' or symbol == '(':
            stack.append(symbol)
            print(stack)
        else:
            if len(stack) == 0:
                return False
            last =stack.pop()
            print(last)
            if not isValidPair(last,symbol):
                return False

    if len(stack) !=0:
        return False
    return True



def isValidPair(left ,right):
    if left == '(' and right == ')':
        return True
    if left == '[' and right == ']':
        return True
    if left == '{' and right == '}':
        return True

if __name__ == '__main__':
    N=int(input())
    
    for i in range(N):
        s=input()
        if isBalanced(s):
            print("YES")
        else:
            print("NO")

