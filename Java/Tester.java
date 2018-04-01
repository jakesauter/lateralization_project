
/**
 * Write a description of class Tester here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Tester
{
    public static void main()
    {
      LinkedListWithTail list = new LinkedListWithTail();
      list.add("A");
      list.add("B");
      list.add("C");
      LinkedListWithTail list2 = new LinkedListWithTail();
      list2.add("E");
      list2.add("F");
      //System.out.println();
      
      System.out.println(list.isEmpty());
      System.out.println("peek " + list.peek());
      list.add("D");
      System.out.println("removing " + list.remove());
      System.out.println(list);
      list.append(list2);
      System.out.println(list);
    }
  
}
