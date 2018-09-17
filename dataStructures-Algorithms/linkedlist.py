##https://www.youtube.com/watch?v=JlMyYuY1aXU&list=PLEJyjB1oGzx3iTZvOVedkT8nZ2cG105U7&index=2
class node:
    def __init__(self,data=None):
        self.data=data
        self.next=None
class linked_list:
    def __init__(self):
        self.head=node()
    def append(self,data):
        new_node=node(data)
        cur=self.head
        while cur.next!=None:
            cur=cur.next
        cur.next=new_node
    def length(self):
        cur=self.head
        total=0
        while cur.next!=None:
            total+=1
            cur=cur.next
        return total
    def display(self):
        elems=[]
        cur_node = self.head
        while cur_node.next!=None:
            cur_node=cur_node.next
            elems.append(cur_node.data)
        print(elems)
#mylist=linked_list();mylist.display(); mylist.append(1); mylist.append(2);mylist.display()
##[]; [1,2] 
"""
C:\Users\AF51360\AppData\Local\Programs\Python\Python36-32\Scripts\;C:\Users\AF51360\AppData\Local\Programs\Python\Python36-32\;C:\Program Files\Java\jdk1.8.0_45\bin

#https://github.com/joeyajames/Python/blob/master/LinkedLists/LinkedList0.py
class Node(object):

    def __init__ (self, d, n = None):
        self.data = d
        self.next_node = n

    def get_next (self):
        return self.next_node

    def set_next (self, n):
        self.next_node = n

    def get_data (self):
        return self.data

    def set_data (self, d):
        self.data = d


class LinkedList (object):

    def __init__(self, r = None):
        self.root = r
        self.size = 0

    def get_size (self):
        return self.size

    def add (self, d):
        new_node = Node (d, self.root)
        self.root = new_node
        self.size += 1

    def remove (self, d):
        this_node = self.root
        prev_node = None

        while this_node:
            if this_node.get_data() == d:
                if prev_node:
                    prev_node.set_next(this_node.get_next())
                else:
                    self.root = this_node.get_next()
                self.size -= 1
                return True		# data removed
            else:
                prev_node = this_node
                this_node = this_node.get_next()
        return False  # data not found

    def find (self, d):
        this_node = self.root
        while this_node:
            if this_node.get_data() == d:
                return d
            else:
                this_node = this_node.get_next()
        return None

myList = LinkedList()
myList.add(5)
myList.add(8)
myList.add(12)
print("size="+str(myList.get_size()))
myList.remove(8)
print("size="+str(myList.get_size()))
print(myList.remove(12))
print("size="+str(myList.get_size()))
print(myList.find(5))"""
