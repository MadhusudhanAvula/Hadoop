'''Counts the occurance of a letter in the command line output ls
https://www.youtube.com/watch?v=LW_kTWzpkK8'''
import commands

output = commands.getoutput('ls')
print output

num = output.count('d')
print num

