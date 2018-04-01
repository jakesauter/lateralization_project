
/**
 * Write a description of class Ex1to10 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import java.util.NoSuchElementException;
public class Ex1to10
{
    public static void main()
    {
        ListNode head = new ListNode("A", null);
        ListNode node1 = new ListNode("B", null);
        ListNode node2 = new ListNode("c", null);
        head.setNext(node1);
        System.out.println(head.getValue() + " " + head.getNext().getValue());
        head = head.getNext();
        head.setNext(node2);
        //head.setNext("C", null);
        System.out.println(hasTwo(head));
        //System.out.println(removeFirst(head).getValue());
        System.out.println(size(head));
        System.out.println(size2(head));
        System.out.println(add(head, "D").getValue());
        System.out.println(reverseList(head).getValue());
    }
    //ex2
    public static boolean hasTwo(ListNode head)
    {
        return head != null && head.getNext() != null;
    }
    
    //ex3
    public static ListNode removeFirst(ListNode head)
    {
        if(head == null)
        {
            throw new NoSuchElementException();
        }
        
        ListNode temp = head.getNext();
        head.setNext(null);
        return temp;
    }
    
    //ex4
    public static int size(ListNode head)
    {
        if(head == null)
        {
            return 0;
        }
        
        int size = 0;
        for(ListNode node = head; node != null; node = node.getNext())
        {
            size++;
        }
        return size;
    }
    
    public static int size2(ListNode head)
    {
        if(head == null)
        {
            return 0;
        }
        
        int size = 0;
        //ListNode node = head;
        //while(node != null)
        while(head != null)
        {
            size++;
            //node = node.getNext();
            head = head.getNext();
            size2(head);
        }
        return size;
    }
    
    //ex5
    public static ListNode add(ListNode head, Object value)
    {
        ListNode node = head;
        if(head == null)
        {
            head = new ListNode(value, null);
        }
        else
        {
            while(node.getNext() != null)
            {
                node = node.getNext();
            }
            ListNode newnode = new ListNode(value, null);
            node.setNext(newnode);
        }
        return head;
    }
    
    //ex6
    public static ListNode reverseList(ListNode head)
    {
        ListNode newHead = null;
        for(ListNode node = head; node != null; node = node.getNext())
        {
            ListNode newNode = new ListNode(node.getValue(), newHead);
        }
        return newHead;
    }
    
    //ex7
    public static ListNode concatenateStrings(ListNode head)
    {
        String temp = "";
        ListNode node = head;
        
        while(node != null)
        {
            temp += node.getValue();
            node.setValue(temp);
            node = node.getNext();
        }
        return node;
    }
    
    //ex8
    public static ListNode rotate(ListNode head)
    {
        ListNode node = head;
        ListNode temp = head.getNext();
        node.setNext(node.getNext());
        while(node != null)
        {
            node = node.getNext();
        }
        node.setNext(temp);
        return node;
    }
    
    //ex9
    public ListNode insertInOrder(ListNode head, String s)
    {
        ListNode node = head;
        
        while(node != null)
        {
            Object val = node.getNext().getValue();
            String value = (String)(val);
            if(value.compareTo(s) < 0)
            {
                ListNode newnode = node;
                newnode.setNext(node.getNext());
                newnode.setValue(s);
                node.setNext(newnode);
            }
            node = node.getNext();
        }
        return node;
    }
    
    //ex10
    public static ListNode middleNode(ListNode head)
    {
        //int size = size(head) / 2, count = 0;
        ListNode node = head, node2 = head;
        while(node.getNext() != null && node2.getNext().getNext() != null)
        {
            node = node.getNext();
            node2 = node2.getNext().getNext();
        }
        return node;
    }
}
