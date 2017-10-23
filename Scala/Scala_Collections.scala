Common Collections
------------------
List

Set


List and Set will take a single element


10
20
30
40
50


Map - Key, value

name=Syed
age=28
city=Hyderabad


Properties File

Dev
Test
Prod


1. Immutable --> We cannot modify


2. Mutable --> We can modify



By default immutable collecitons will be added to your class

com.immutable.Map

com.mutable.Map


val numbers = List(32,95,31,40)
val colors = List("red","green","blue")


val combine = List(10,20,"red","blue")


println(s"I have ${colors.size} colors - $colors")

head
tail

colors.head() -- Wrong

colors.head(1)

colors.head

colors(1)

val numbers = List(32,95,31,40)

var total = 0; for(i <- numbers) { total += i }

val total = 0; for(i <- numbers) { total += i } --> Wrong

for(c <- colors) {println(c)}

colors.foreach((c:String) => println(c))




Map :
colors.map((c:String) => c.size)

Reduce  :

Single ==> merges all the elements

numbers
res14: List[Int] = List(32, 95, 31, 40)


val total = numbers.reduce((a: Int, b: Int) => a + b )

xxxxx + 31 = xxx


foreach() takes a function/procedure and invokes it every item in the list
map() takes a function that converts a single list element to antoher value or another data type
reduce() take a function that combines two list elements into a single element.

val numbers = List(32,95,31,32,40)



Set : 

val unique = Set(10,20,30,20,40,20)


Map : key, value

val colorMap = Map("red" -> 0xFF000, "green" -> 0xFF99, "blue" -> 0x5544)

val redColor = colorMap("red")

for(pairs <- colorMap) { println(pairs) }

Iterable --> Traversable


val nestedList = List(List(1,2,3), List(4,5,6))

val keyPairs = List(('A',65), ('B',66), ('C',67))


val primes = List(2,3,4,5,3)


var i = primes

while(!i.isEmpty) { print(i.head + ", "); i = i.tail }


val l : List[Int] = List()
val l = List()


When you create a list, the last element is Nil.
Nil is a singleton object object of an List[Nothing]


val m : List[String] = List("a")


val m : List[String] = List("a")
m: List[String] = List(a)

scala> m.head
res20: String = a

scala> m.tail
res21: List[String] = List()

scala> m.tail == Nil
res22: Boolean = true


Cons Operator -       ::

val numbers = List(1,2,4,6)
     or
val numbers = 1 :: 2 :: 4 :: 6 :: Nil

val numbers = Nil :: 1 :: 2 :: 4 :: 6 :: Nil

:: --> method of a List class

::, ++, -- these are methods


sum(30)
::(1)


val first = Nil.::(1)

first.tail == Nil

val second = 2 :: first

:: 

1 :: 2 :: Nil


List(1,2) ::: List(2,3)


List(1,2) ++ Set(3,4,3)


List(1,2,2,2,4,5,8).distinct


List(1,2,6,4,3,2,4).drop(2)

List(1,2,6,4,3,2,4) drop 2


List(1,2,6,4,3,2,4).filter(_ > 2)

Predicate Function


List(1,2,6,4,3,2,4).partition(_ < 3)

List(1,2,6,4,3,2,4).partition(_ < 3)
res8: (List[Int], List[Int]) = (List(1, 2, 2),List(6, 4, 3, 4))

Grouping the elements into a tuple

Flatten:

List(List(1,2),List(3,4)).flatten


List(10,20,30).reverse




List(2,3,5,7).slice(1,3)

List("banana","apple","orange").sortBy(_.size)


List("banana","apple","orange").sorted


List(2,3,5,7).splitAt(2)

List(1,2,3,4,5).take(2)



List(1,2) zip List("A","B")

 List(1,2) zip List("A","B")
res15: List[(Int, String)] = List((1,A), (2,B))

List(1,2).zip(List("A","B"))


val a = List(1,2,3,4,5)


var a = List(1,2,3,4,5)

a.dropRight(2)
a.takeRight(2)

map
flatMap

List("apple","banana").map(_.toUpperCase)

List("apple,banana").flatMap(_.split(','))


List(10,20,30).max
List(10,20,30).min
List(10,20,30).product
List(10,20,30).sum



List(10,20,30).contains(30)
List(10,20,30).endsWith(List(20,30))
List(100,200,300,400).exists(_ < 200)




Convertions:
------------
List(10,20,30).mkString(", ")

List(10,20,30).toBuffer

Map("A" -> 1, "B" -> 2).toList


Set(1 -> true, 3 -> false).toMap

List(2,3,2,1).toSet
List(10,20,30).toString



import collection.JavaConverters._

List(10,20).asJava

new java.util.ArrayList(10).asScala




Pattern Matching With Collections
---------------------------------
val status = List(500,404)


val message = status.head match {

 case a if a <= 499 => "Matched"
 case _ => "Nothing Matched"

}



val message = status match {

 case List(404,500) => "Not Matched"
 case List(500,300) => "Error"
 case List(500,404) => "Matched"
 case _ => "Not Sure What Happened"

}



Immutable

scala.collection.mutuable


val m = Map("A" -> 1, "B" -> 2)

val n = m - "A" + ("C" -> 3)



Immutable Types				Mutuable Types
colleciton.immutable.List		colleciton.mutuable.Buffer
collection.immutable.Set		colleciton.mutuable.Set
collection.immutable.Map		collection.mutable.Map




import scala.collection.mutable.Buffer
val nums = collection.mutable.Buffer(1)



for(i <- 2 to 10) nums += i


val a = nums.toList

val m = Map("A" -> 1, "B" -> 2)
m.toBuffer



Builder
-------

val b = Set.newBuilder[Char]


Monadic Collection:
Option: A Option Collection whose size will always be a 1


Option
Some
None




var a : String = "Veera"


var b = Option(a)
b: Option[String] = Some(Veera)

a = null

var b = Option(a)
b: Option[String] = None

10/0 



def divide(a : Double, b : Double) : Option[Double] = {

if(b == 0) None
else Option(a/b)

}





Seq:
----

Immutable:
val x = Seq(1,2,3,4,5)
x: Seq[Int] = List(1, 2, 3, 4, 5)


val x = IndexedSeq(1,2,3,4,5)
x: IndexedSeq[Int] = Vector(1, 2, 3, 4, 5)


val x = scala.collection.immutable.LinearSeq(1,2,3,4,5)
x: scala.collection.immutable.LinearSeq[Int] = List(1, 2, 3, 4, 5)

val n = Vector(1,2,3,4,5)


1. Choosing a correct collection class

Given a party, all couples are invited

Map 
Either Immutable or Mutable

val x = List(1, 2.0,33D, 400L)


val x = List[Number](1, 2.0,33D, 400L)


Mutable variables with immutable collections
---------------------------------------------

ShortCut Way:
var system = Vector("IBM")

system = system :+ "Dell"

system.foreach(println)


Long Way:
var system = Vector("IBM")
system = Vector("IBM","Dell")

system(0)

system(0) = "Acer"



import scala.collection.mutable.ArrayBuffer



val x = ArrayBuffer()
val x = ArrayBuffer[String]()

val nums = ArrayBuffer(1,2,3,4,5)

scala> num += 6
<console>:13: error: not found: value num
       num += 6
       ^

scala> nums += 6
res8: nums.type = ArrayBuffer(1, 2, 3, 4, 5, 6)

scala> nums += (7,8)
res9: nums.type = ArrayBuffer(1, 2, 3, 4, 5, 6, 7, 8)

scala> nums ++= (9,10)
<console>:14: error: too many arguments (2) for method ++=: (xs: scala.collection.TraversableOnce[Int])nums.type
       nums ++= (9,10)
                   ^

scala> nums ++= List(9,10)
res11: nums.type = ArrayBuffer(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)


nums -= 6

nums :+ 50


nums -= (3,4)

nums --= List(5,4,3)


+= ----------> it is acting as a mutable and storing into the same variable
:+ --> it is acting as an immutable, it doesnt store into a same variable


val x = nums :+ 60
x: scala.collection.mutable.ArrayBuffer[Int] = ArrayBuffer(1, 2, 3, 4, 5, 7, 8, 9, 10, 60)

scala> x
res19: scala.collection.mutable.ArrayBuffer[Int] = ArrayBuffer(1, 2, 3, 4, 5, 7, 8, 9, 10, 60)

scala> nums += 100
res20: nums.type = ArrayBuffer(1, 2, 3, 4, 5, 7, 8, 9, 10, 100)


append
insert
insertAll
prepend


val x = Vector(1,2,3,4,5)


x.foreach((i : Int) => println(i))
x.foreach(i => println(i))
x.foreach(println(_))

x.foreach(println)


val system = Traversable("IBM","Dell","Acer","Sony")

for(i <- system) println(i)



for(i <- system) println(i.toUpperCase)


for(i <- system) {
val a = i.toUpperCase
println(a)
}

val result = for(i <- system) yield i.toUpperCase

val system = Array("IBM","Dell","Acer","Sony") 
val result = for(i <- system) yield i.toUpperCase


val coupes = Map("Ajay" -> "Jaya", "Sunil" -> "Sunitha")

for((k,v) <- coupes) println(s"Key : $k, Value : $v ")

<-   we can call this as an assigner or in operator



zip or zipWithIndex:
--------------------

val days = Array("Sunday","Monday","Tuesday","Wednesday","Thurday","Friday","Saturday")

days.zipWithIndex.foreach {
 case(day, count) => println(s" $count is $day")
}


for((day,count) <- days.zipWithIndex) {
   println(s"$count is $day")
}


val list = List("Syed","Raju","Shiva","Abhishek","Veera")
val listWithCount = list.zipWithIndex


Tuple1, Tuple2, Tuple3
Tuple22


Iterator:
---------
val it = Iterator(1,2,3,4,5,6,7,8,9)

while(it.hasNext) {
 println(it.next())
}

it.foreach(println)


Transform one collection type to another collection type
--------------------------------------------------------

for/yield

val a = Array(1,2,3,4,5)


for(x <- a) yield x

for(x <- a) yield x * 5




val names = Vector("Syed","Raju","Shiva","Abhishek","Veera")

for(x <- 0 until names.length) yield (x, names(x))


var i = for(name <- names) yield {
val a = name.toUpperCase
a
}


val names = Vector("syed","raju","shiva","abhishek","veera")
val names1 = names.map(e => e.capitalize)
val names1 = names.map(e => e.toUpperCase)

val names1 = names.map(_.capitalize)

val elements = names1.map(a => <li>{a}</li>)




Chaning Mechanism
------------------
calling multiple methods

val names = "Syed, Veera , Raju     , Madhu";

val result = names.split(",").map(_.trim)


Flatten
-------
val nestedList = List(List(1,2), List(3,4))

val nestedresult = nestedList.flatten

val characters = List("Hello", "Syed")

val charResult = characters.flatten

val optionCollection = Vector(Some(100), Some(200), None, Some(500), None)

val optionCollection = Vector(Some(100), Some(200), Some("Raju"), None, Some(500), None)

val optionResult = optionCollection.flatten

val optionResult2 = optionResult.flatten  --> Wrong


flatMap
-------
FlatMap = Flatten + Map

val words = List("Syed","Shiva","Raju","Veera")

subWords(words)

words.map(subWords)

words.flatMap(subWords)

val words = List("Syed","Shiva","Raju","Veera", 100, 300, 400)

val result = words.filter {

case a : String => true
case _ => false

}


val numbers = List(1,2,3,4,5,6,7,8,9)
groupBy
partition

val a= numbers.groupBy(_ > 5)
res20: scala.collection.immutable.Map[Boolean,List[Int]] = Map(false -> List(1, 2, 3, 4, 5), true -> List(6, 7, 8, 9))

val b = numbers.partition(_ > 5)
b: (List[Int], List[Int]) = (List(6, 7, 8, 9),List(1, 2, 3, 4, 5))

val(x,y) = numbers.partition(_ > 5)

Sliding
-------
numbers.sliding(2).toList

res23: List[List[Int]] = List(List(1, 2), List(2, 3), List(3, 4), List(4, 5), List(5, 6), List(6, 7), List(7, 8), List(8, 9))

// Size, Step
numbers.sliding(2,2).toList
res24: List[List[Int]] = List(List(1, 2), List(3, 4), List(5, 6), List(7, 8), List(9))

numbers.sliding(2,3).toList
res25: List[List[Int]] = List(List(1, 2), List(4, 5), List(7, 8))

reduce
reduceLeft
reduceRight

fold
foldLeft
foldRight

val numbers = List(10,20,30,40,50,60,70)

numbers.reduce(_ + _)
numbers.reduceLeft(_ + _)
numbers.reduceRight(_ + _)

val numbers = List(1,2,3)
Seed Value:
numbers.fold(0)(_ + _)

numbers.fold(10)(_ + _)
foldLeft
foldRight

List:
-----
val numbers =  List(1,2,3,4,5,6,7)
val numbers = 1 :: 2 :: 3 :: 4 :: 5 :: 6 :: 7 :: Nil
val numbers = List(1, 2.5, 77D, 88L)
val numbers = List[Number](1, 2.5, 77D, 88L)
val numbers = List.range(1,50)
val numbers = List.range(1,50,2)


val numbers = List(1,2,3,4,5,6,7)

val numbers2 = 8 :: numbers

var numbers = List(1,2,3,4,5,6,7)


ListBuffer
----------
import scala.collection.mutable.ListBuffer

val numbers = ListBuffer(1,2,3)

val numbers = new ListBuffer()

val numbers = new ListBuffer[Double]()

numbers += 4

numbers += (5,6,7)

numbers ++= Seq(8,9,10)


-=

val numberList = numbers.toList

val numbers = 1 :: 2 :: 3 :: 4 :: 5 :: 6 :: 7 :: Nil


Stream:  Lazy Collection

val numbersStream = 1 #:: 2 #:: 3 #:: 4 #:: 5 #:: 6 #:: 7 #:: Stream.empty

numbersStream.head
numbersStream.tail
numbersStream(0)
numbersStream(6)
val numbersStream = (1 to 10000000).toStream

val numbersStream = Stream(1,2,3,4,5,6,7,8)

val numArray = Array(4,7,2,9,3)

val strArray = Array("Syed","Veera","Shiva","Madhu","Raju","Abhi")

scala.util.sorting.quickSort(strArray)

StringOps ==> implicit ordering

val namesArray = Array("Syed","veera","Shiva")

namesArray(0)

val resulr = namesArray.filter(_.contains("Syed"))

val states = Map("TL" -> "Telanagana", "AP" -> "AndhraPradesh", "MH" -> "Maharashtra")

states("TL")
states("UP")
val states = Map("TL" -> "Telanagana", "AP" -> "AndhraPradesh", "MH" -> "Maharashtra").withDefaultValue("No Key Found")

states.getOrElse("AP","No State Found")
states.get("TL")
states.foreach(result => println(s"Key : ${result._1}, Value : ${result._2}"))

------------------------------------------------------------
states.foreach {
case(StateKey,StateValue) => println(s"Key : StateKey, Value : StateValue")
}
------------------------------------------------------------

states.keys.foreach((statekey) => println(statekey))

states.values.foreach((stateValue) => println(stateValue))

val resultsMapValues = states.mapValues(_.toUpperCase)

states.keys
states.values
states.keySet
states.keysIterator
states.valuesIterator

val sortResult = scala.collection.SortedSet(10,6,4,30,1,2,3,7)

The return type for SortedSet is a TreeSet.
TreeSet follows a natural sorting order(Comparable), Comparator

val sortResult = scala.collection.mutable.LinkedHashSet(10,6,4,30,1,2,3,7)

SortedSet = Immutable
If you need a mutable version = TreeSet

LinkedHashSet  = Mutable

Queue: FIFO
Mutable + Immutable

import scala.collection.mutable.Queue

val result = Queue(1,2,3,4,5,6,7)

val result = Queue()
val result = Queue[String]()

result += 8

result.dequeue
result.enqueue(100)
Stack = LIFO

Mutable + Immutable

import scala.collection.mutable.Stack


val result = Stack(1,2,3,4,5)
val result = Stack()
val result = Stack[Int]()

result.push(100)

scala> result.pop
res44: Int = 100

scala> result.top
res45: Int = 1

scala> 

scala> result.size
res46: Int = 5

scala> result.clear

scala> result
res48: scala.collection.mutable.Stack[Int] = Stack()

Diff bw
1 to 10   
1 until 10

4 min
1. Write a for loop using Range operator
   1 to 100 

5 min
2. Create a a two map objects and add it in immutable mode

map1 ++ map2
map1.++(map2)
List.concact(m1,m2)
concact
map1 :: map2 

List --> Map

List(1,2,3,4,5,6,7,4,2,5,4,3,2).toMap


List(1,2,3,4,5,6,7,4,2,5,4,3,2).toSet
List(1,2,3,4,5,6,7,4,2,5,4,3,2).distinct
res35: List[Int] = List(1, 2, 3, 4, 5, 6, 7)

List 

val x = collection.mutable.ArrayBuffer(10,20,30,40,50)

x ++= Seq(100,200,300)

val y = collection.mutable.ArrayBuffer(10,20,30,40,50)


val  z = x ++ y

val z = x.intersect(y)

val a = List(1,2,3)
val b = List(3,4,5)

scala> val c = a ::: b
c: List[Int] = List(1, 2, 3, 3, 4, 5)

scala> val c = a ++ b
c: List[Int] = List(1, 2, 3, 3, 4, 5)
val names = List("Syed","veera","Raju","Madhu")

names.mkString

names.toString

 val a  = Array(1,2,3,4)
a: Array[Int] = Array(1, 2, 3, 4)

scala> a.toString
res42: String = [I@2d308312



ReferenceBooks
--------------
1. Scala in Action
2. Scala CookBook
3. Programming in Scala
4. Scala in Depth


ListBuffer
ArrayBuffer --> Indexing

99






























































































































































































































 





















































































