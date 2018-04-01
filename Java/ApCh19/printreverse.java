import java.util.LinkedList;
import java.util.Iterator;
import java.util.ListIterator;
public class printreverse
{
    public static void reverse(LinkedList<Object> list)
    {
         int index = list.size();
         ListIterator iter = list.listIterator(index);
         for(Object o : list)
         {
             System.out.println(o);
             iter.previous();
         }
    }   
}
