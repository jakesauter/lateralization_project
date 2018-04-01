
/**
 * Write a description of class Test here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Test
{
    public static void main()
    {
       Object[] a = {"g", "a", "c"};
       SinglyLinkedList list = new SinglyLinkedList(a);
    
       //System.out.println("contains 3: " + list.contains(3));
       //System.out.println("contains 7: " + list.contains(7));
       //System.out.println("index of 1: " + list.indexOf(1));
       //System.out.println("index of 2: " + list.indexOf(1));
       //System.out.println("add 4: " + list.add(4));
       //System.out.println("remove 1: " + list.remove(1) + " " + list);
       //System.out.println("get: " + list.get(2));
       //System.out.println("set: " + list.set(1, 0));
       //list.add(1, 4);
       //System.out.println("remove: " + list.remove(2));
       //System.out.println(list.toString());
       
        ListNode node1 = new ListNode("c", null);
        ListNode node2 = new ListNode("a", null);
        ListNode node3 = new ListNode("g", null);
        node1.setNext(node2);
        node2.setNext(node3);
       sort(node1);
      ListNode node;
       String s = "";
       for(node = node1; node != null; node = node.getNext())
       {
        s += node.getValue() + " ";
       }
       System.out.println(s);
       //System.out.println(list);

    }
    
    public static void sort(ListNode head)
  {
      ListNode firstNode, node;
      
      for(firstNode = head; firstNode != null; firstNode = firstNode.getNext())
      {
         for(node = head; node != null; node = node.getNext())
         {
             String firstval = (String)(firstNode.getValue());
             String nodeval = (String)(node.getValue());
             if(firstval.compareToIgnoreCase(nodeval) < 0)
             {
                 String temp = firstval;
                 firstNode.setValue(nodeval);
                 node.setValue(temp);
             }
         }
      }
  }    
}