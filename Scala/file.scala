//reading the file
import scala.io.Source

val source = Source.fromFile("FileName") //source.hasnext, source.next
val lines = source.getLines  //lines.next
//val nums = lines.filter(_.nonEmpty).map(_.toInt) , printlm(nums.sum)
source.close()

//writing to a file
//By using printWriter it will overwrite the existing file
import java.io.PrintWriter
val pw = new PrintWriter("")
pw.println("The Fiest Line")
Array(1,2,3,4,5).foreach(i=>pw.println(i))
pw.close()
//FileWriter
import java.io.FileWriter
val fw = new PrintWriter(new FileWriter("",true)) // false means erase the file
