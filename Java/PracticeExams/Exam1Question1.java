public class Exam1Question1
{
   public static String replaceOne(String text, int i, int n, String sub)
   {
       return text.substring(0, i) + sub + text.substring(i + n);
   }
   
   public static String replaceAll(String text, String what, String sub)
   {
       int i, n;
       i = 0;
       n = what.length();
       savedText.add(text);
       while(i >= 0)
       {
           i = text.indexOf(what);
           if(i >= 0)
           {
               text = replaceOne(text, i, n, sub);
           }
       }
       return text;
   }
   
   public static String undoReplaceAll()
   {
       if(savedText.size() == 0)
       {
           return null;
       }
       return savedText.remove(savedText.size() - 1);
   }
}
