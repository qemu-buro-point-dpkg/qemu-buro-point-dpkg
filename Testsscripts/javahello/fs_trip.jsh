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

// this is not a java statement
/exit
