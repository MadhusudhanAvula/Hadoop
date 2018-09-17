##data structures and algorithms
### Inserting a value into a Binary Search Tree in Python

class Tree(object):
  def __init__(self,entry,left=None,right=None):
    self.entry=entry
    self.left=left
    self.right=right

def insert(item,tree):
  if(item < tree.entry):
    if(tree.left!= None):
      insert(item,tree.left)
    else:
      tree.left = Tree(item)
  else:
    if (tree.right != None):
      insert(item, tree.right)
    else:
      tree.right =Tree(item)
