Operator syntax	                  Description	
-a <FILE>	                        True if <FILE> exists. :!: (not recommended, may collide with -a for AND, see below)	
-e <FILE>	                        True if <FILE> exists.	
-f <FILE>	                        True, if <FILE> exists and is a regular file.	
-d <FILE>	                        True, if <FILE> exists and is a directory.
-c <FILE>	                        True, if <FILE> exists and is a character special file.	
-b <FILE>	                        True, if <FILE> exists and is a block special file.	
-p <FILE>	                        True, if <FILE> exists and is a named pipe (FIFO).	
-S <FILE>	                        True, if <FILE> exists and is a socket file.	
-L <FILE>	                        True, if <FILE> exists and is a symbolic link.	
-h <FILE>	                        True, if <FILE> exists and is a symbolic link.	
-g <FILE>	                        True, if <FILE> exists and has sgid bit set.	
-u <FILE>	                        True, if <FILE> exists and has suid bit set.	
-r <FILE>	                        True, if <FILE> exists and is readable.	
-w <FILE>	                        True, if <FILE> exists and is writable.	
-x <FILE>	                        True, if <FILE> exists and is executable.	
-s <FILE>	                        True, if <FILE> exists and has size bigger than 0 (not empty).	
-t <fd>	                            True, if file descriptor <fd> is open and refers to a terminal.	
<FILE1> -nt <FILE2>	                True, if <FILE1> is newer than <FILE2> (mtime). :!:	
<FILE1> -ot <FILE2>	                True, if <FILE1> is older than <FILE2> (mtime). :!:	
<FILE1> -ef <FILE2>	                True, if <FILE1> and <FILE2> refer to the same device and inode numbers. :!:	

String tests
Operator syntax	                 Description
-z <STRING>	                     True, if <STRING> is empty.
-n <STRING>	                     True, if <STRING> is not empty (this is the default operation).
<STRING1> = <STRING2>	           True, if the strings are equal.
<STRING1> != <STRING2>	         True, if the strings are not equal.
<STRING1> < <STRING2>	           True if <STRING1> sorts before <STRING2> lexicographically (pure ASCII, not current locale!). Remember to escape! Use \<
<STRING1> > <STRING2>	           True if <STRING1> sorts after <STRING2> lexicographically (pure ASCII, not current locale!). Remember to escape! Use \>

Arithmetic tests
Operator syntax	                Description
<INTEGER1> -eq <INTEGER2>	      True, if the integers are equal.
<INTEGER1> -ne <INTEGER2>	      True, if the integers are NOT equal.
<INTEGER1> -le <INTEGER2>	      True, if the first integer is less than or equal second one.
<INTEGER1> -ge <INTEGER2>	      True, if the first integer is greater than or equal second one.
<INTEGER1> -lt <INTEGER2>	      True, if the first integer is less than second one.
<INTEGER1> -gt <INTEGER2>	      True, if the first integer is greater than second one.

Misc syntax
Operator syntax	               Description
<TEST1> -a <TEST2>	           True, if <TEST1> and <TEST2> are true (AND). Note that -a also may be used as a file test (see above)
<TEST1> -o <TEST2>	           True, if either <TEST1> or <TEST2> is true (OR).
! <TEST>	                     True, if <TEST> is false (NOT).
( <TEST> )	                   Group a test (for precedence). Attention: In normal shell-usage, the "(" and ")" must be escaped; use "\(" and "\)"!
-o <OPTION_NAME>	             True, if the shell option <OPTION_NAME> is set.
-v <VARIABLENAME>	             True if the variable <VARIABLENAME> has been set. Use var[n] for array elements.
-R <VARIABLENAME>	             True if the variable <VARIABLENAME> has been set and is a nameref variable (since 4.3-alpha)




Number of Arguments Rules
The test builtin, especially hidden under its [ name, may seem simple but is in fact causing a lot of trouble sometimes. One of the difficulty is that the behaviour of test not only depends on its arguments but also on the number of its arguments.

Here are the rules taken from the manual (Note: This is for the command test, for [ the number of arguments is calculated without the final ], for example [ ] follows the "zero arguments" rule):

0 arguments
The expression is false.
1 argument
The expression is true if, and only if, the argument is not null
2 arguments
If the first argument is ! (exclamation mark), the expression is true if, and only if, the second argument is null
If the first argument is one of the unary conditional operators listed above under the syntax rules, the expression is true if the unary test is true
If the first argument is not a valid unary conditional operator, the expression is false
3 arguments
If the second argument is one of the binary conditional operators listed above under the syntax rules, the result of the expression is the result of the binary test using the first and third arguments as operands
If the first argument is !, the value is the negation of the two-argument test using the second and third arguments
If the first argument is exactly ( and the third argument is exactly ), the result is the one-argument test of the second argument. Otherwise, the expression is false. The -a and -o operators are considered binary operators in this case (Attention: This means the operator -a is not a file operator in this case!)
4 arguments
If the first argument is !, the result is the negation of the three-argument expression composed of the remaining arguments. Otherwise, the expression is parsed and evaluated according to precedence using the rules listed above
5 or more arguments
The expression is parsed and evaluated according to precedence using the rules listed above

#http://wiki.bash-hackers.org/commands/classictest
##################################################################################################################################
read [-ers] [-u <FD>] [-t <TIMEOUT>] [-p <PROMPT>] [-a <ARRAY>] [-n <NCHARS>] [-d <DELIM>] [-i <TEXT>] [<NAME...>]
The read builtin reads one line of data (text, user input, …) from standard input or a supplied filedescriptor number into one or more variables named by <NAME…>.

Since Bash 4.3-alpha, read skips any NUL (ASCII code 0) characters in input.

If <NAME…> is given, the line is word-split using IFS variable, and every word is assigned to one <NAME>. The remaining words are all assigned to the last <NAME> if more words than variable names are present.

Option	Description
-a <ARRAY>	read the data word-wise into the specified array <ARRAY> instead of normal variables
-d <DELIM>	recognize <DELIM> as data-end, rather than <newline>
-e	on interactive shells: use Bash's readline interface to read the data
-i <STRING>	preloads the input buffer with text from <STRING>, only works when Readline (-e) is used
-n <NCHARS>	reads <NCHARS> characters of input, then quits
-N <NCHARS>	reads <NCHARS> characters of input, ignoring any delimiter, then quits
-p <PROMPT>	the prompt string <PROMPT> is output (without a trailing automatic newline) before the read is performed
-r	raw input - disables interpretion of backslash escapes and line-continuation in the read data
-s	secure input - don't echo input if on a terminal (passwords!)
-t <TIMEOUT>	wait for data <TIMEOUT> seconds, then quit (exit code 1). Fractional seconds ("5.33") are allowed since Bash 4. A value of 0 immediately returns and indicates if data is waiting in the exit code. Timeout is indicated by an exit code greater than 128. If timeout arrives before data is read completely (before end-of-line), the partial data is saved.
-u <FD>	use the filedescriptor number <FD> rather than stdin (0)
When both, -a <ARRAY> and a variable name <NAME> is given, then the array is set, but not the variable.

Of course it's valid to set individual array elements without using -a:

##Most of the GNU tools that make use of regular expressions (regex)
 [[:alnum:]]  - [A-Za-z0-9]     Alphanumeric characters
 [[:alpha:]]  - [A-Za-z]        Alphabetic characters
 [[:blank:]]  - [ \x09]         Space or tab characters only
 [[:cntrl:]]  - [\x00-\x19\x7F] Control characters
 [[:digit:]]  - [0-9]           Numeric characters
 [[:graph:]]  - [!-~]           Printable and visible characters
 [[:lower:]]  - [a-z]           Lower-case alphabetic characters
 [[:print:]]  - [ -~]           Printable (non-Control) characters
 [[:punct:]]  - [!-/:-@[-`{-~]  Punctuation characters
 [[:space:]]  - [ \t\v\f]       All whitespace chars
 [[:upper:]]  - [A-Z]           Upper-case alphabetic characters
 [[:xdigit:]] - [0-9a-fA-F]     Hexadecimal digit characters


