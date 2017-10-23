Functions:
----------

Method - class
Function - Object


EOP - Expression Oriented Programming

Statements --> Executes the Code, but does not return any thing

retailer.product()

Expressions
val productDetails = retailer.product()

val test = if(3 > 2) "true" else "false"

boolean test = 3 > 2 ? true : false;  (In Java)


Function Literals

Traits
Function1, Function2, Function3 ..... Function22


val add = (x:Int, y:Int) => x+y


def functionName ([list of parameters]) : [returnType]


def functionName([list of parameters]) : [return Type] = {

function body

return 

}


Val Arguments
--------------
We can pass as many arguments as we can(Not used in realtime because in real time we will get confused with arguments)

object FunValArg
 def main(arg : Array[String]){

 }
   // Array[String] = String*
 def printme(a: string*)

Nested Functions:
-------------------
Function inside a Function

Partial Added Functins:
------------------------
we doesn't need to pass the same arguement for several times.
val Pdfdept = printme( Big Data, _: String)
  Pdfdept("Avula")  // Big Data  Avula
  Pdfdept("AV")  // Big Data  AV

 def printme( dept, name:String){
 	println(dept + "....." + name)
 }


Higher Order Function
---------------------
There are the functions which takes other functions as a parameter

def operation(functionParam:(Int, Int) => Int){
 println(functionParam(4,4))

}

val add = (x: Int, y : Int) => {x + y}

operation(add)


After compiling

def operation(add:(4, 4) => Int){
 println(add(4,4))

}


val mul = (x: Int, y : Int) => {x * y}


(name : String) => { "Hello " + name  }
res5: String => String = $$Lambda$1054/337460547@6ca372ef

scala> def getMessage = (name : String) => { "Hello " + name  }
getMessage: String => String

scala> getMessage("Sahul")
res6: String = Hello Sahul

scala> getMessage()
<console>:13: error: not enough arguments for method apply: (v1: String)String in trait Function1.
Unspecified value parameter v1.
       getMessage()
                 ^


scala> val msg = getMessage
msg: String => String = $$Lambda$1056/584694804@46dcbeab

scala> msg("Raju")
res8: String = Hello Raju

(name:String) => {"hello" + name}

def getMessage = (name : String) => { "Hello " + name  }
def add = (a : Int) => { "Hello" + a }



def getMessage(name : String) = { "hello " + name }

def getMessage(name : String) : String = { "hello " + name }
def add = (a : Int) => { "Hello" + a }



def getMessage(name : String) : Unit = { "hello " + name }

def getMessage(name : String) => { "hello " + name } --> Wrong

def getMessage = (name : String) = { "Hello " + name  } --> Wrong
def getMessage => (name : String) = { "Hello " + name  } --> Wrong
def getMessage = (name : String):String => { "Hello " + name  } --> Wrong

def add (x : Int, y : Int) : String = { val sum = x+y;sum.toString()}
def add = (x : Int, y : Int) : String => { val sum = x+y;sum.toString()}



When you write = before the parameter then add => before function body
when you write = after the parameter then add = before function body


Curried Function
----------------

Currying function is a function with multiple parameters creating a chain of function, and each expecting 
a single parameter

val add = (x : Int, y : Int) => x + y

def add(x : Int)(y : Int) = x + y

val addUncurried = Function.uncurried(add _)


def strcat(s1:String)(s2:String) = s1+s2
          or
def strcat(s1:String) = (s2:String) => s1+s2

Closure
---------
A closure is a function whose return value is depends on the value on one or more variable, that variable
will be outside the function

val multiplier = (x:Int) => x * 10

val y = 20
val multiplier = (x:Int) => x * y

Write a simple program to perform add function

= 

=>


Partial Applied Function:
-------------------------
val add = (x : Int, y: Int) => x+y

val partialAdd = add(1, _:Int)




scala> val add = (x : Int, y: Int) => x+y
add: (Int, Int) => Int = $$Lambda$1306/405787243@5dc120ab

scala> add(4,4)
res34: Int = 8

scala> val partialAdd = add(10, _:Int)
partialAdd: Int => Int = $$Lambda$1307/529864074@31fc658f

scala> partialAdd(100)
res35: Int = 110








Collections

OOPS

utilities - file processing, sbt, java integr, perfors, examples

Scala - Avro Schema kafka with out spark































































