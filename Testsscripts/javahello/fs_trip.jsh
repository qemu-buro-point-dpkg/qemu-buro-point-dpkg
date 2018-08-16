// fs-navigation intents in jshell tbi
// such as http://forward-media.de/tutorial/kommandozeilen-crashkurs
// hint: this seems by now the most complete tutorial available for jshell on away to abs jshell https://www.pluralsight.com/guides/getting-started-with-jshell
// hint: you can paste it to jshell console, too

//cd? /home #buggy https://stackoverflow.com/questions/4884681/how-to-use-cd-command-using-java-runtime In a Java program you can't change your current working directory and you shouldn't need to. Simply use absolute file paths.
//donts



// ls #ok (in bash console pwd)
File curDir = new File(".");File[] filesList = curDir.listFiles();for(File f : filesList){System.out.println(f.getName());}

//execute a linux program file ok
Runtime.getRuntime().exec("sh -c '/usr/bin/xcalc'")

//read from file, manipulate string, write it to a file
String fileContent = new String(java.nio.file.Files.readAllBytes(java.nio.file.Paths.get("/tmp/qemuburotest/logs"))); System.out.println(fileContent)
//read content from file, into string and echo

String ti = fileContent.concat("ddd")
System.out.println(ti)
import java.nio.file.Paths;
import java.nio.file.Files;

Files.write(Paths.get("/tmp/qemuburotest/logs1"), ti.getBytes());
// writen to file, append?:string manipulation as is?
//https://github.com/eugenp/tutorials/tree/master/core-java-io Java – Write to File give 6 Ways: one 
// https://github.com/aruld/java-oneliners/wiki 10 Java One Liners to Impress Your Friends https://dzone.com/articles/writing-one-liners-in-java-8 
// starting a "main" class from commandline 
// this is not a java statement
// now? pls "find", "regex"-sed; grep ; date; function, class advanced things?

/exit
