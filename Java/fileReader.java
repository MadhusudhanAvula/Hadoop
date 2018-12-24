//https://funnelgarden.com/java_read_file/
//*BufferedReader reads an entire line at a time, instead of one character at a time like FileReader. It’s meant for reading text files.*/
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class ReadFile_BufferedReader_ReadLine {
  public static void main(String [] args) throws IOException {
    String fileName = "c:\\temp\\sample-10KB.txt";
    FileReader fileReader = new FileReader(fileName);
    
    try (BufferedReader bufferedReader = new BufferedReader(fileReader)) {
      String line;
      while((line = bufferedReader.readLine()) != null) {
        System.out.println(line);
      }
    }
  }
}

//*Files.readAllBytes()
Even though the documentation for this method states that “it is not intended for reading in large files” I found this to be the absolute best performing file reading method, even on files as large as 1GB.*/
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

public class ReadFile_Files_ReadAllBytes {
  public static void main(String [] pArgs) throws IOException {
    String fileName = "c:\\temp\\sample-10KB.txt";
    File file = new File(fileName);

    byte [] fileBytes = Files.readAllBytes(file.toPath());
    char singleChar;
    for(byte b : fileBytes) {
      singleChar = (char) b;
      System.out.print(singleChar);
    }
  }
}
//*Performance Rankings
Here’s a ranked list of how well each file reading method did, in terms of speed and handling of large files, as well as compatibility with different Java versions.

Rank	File Reading Method
1	java.nio.file.Files.readAllBytes()
2	java.io.BufferedFileReader.readLine()
3	java.nio.file.Files.lines()
4	java.io.BufferedInputStream.read()
5	java.util.Scanner.nextLine()
6	java.nio.file.Files.readAllLines()
7	org.apache.commons.io.FileUtils.readLines()
8	com.google.common.io.Files.readLines()
9	java.io.FileReader.read()
10	java.io.FileInputStream.Read()
*/
