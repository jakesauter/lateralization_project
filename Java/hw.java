
/**
 * Write a description of class hw here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class hw
{
//     public static void main()
//     {
//         ListNode2 header = new ListNode2(0, null, null); 
//         ListNode2 node1 = new ListNode2(5, null, null); 
//         ListNode2 node2 = new ListNode2(7, null, null); 
//         header.setNext(node1);
//         node1.setPrevious(header);
//         node1.setNext(node2);
//         node2.setPrevious(node1);
//         
//         Integer x = new Integer(6);
//         header.insertInOrder(x);
//         for(ListNode node = header; node != null; node = node.getNext())
//        {
//           s += node.getValue() + " ";
//        }
//        System.out.println(s);
//     }
    
    //ex21
    public int countZeroes(ListNode head)
    {
        int count = 0;
        Integer zero = new Integer(0);
        for(ListNode node = head; node != null; node = node.getNext())
        {
            if(node.getValue().equals(zero))
            {
                count++;
            }
        }
        return count;
    }
    
    //ex22
    public void remove(Object obj)
    {
        ListNode prev = null;
        ListNode node = head;
        
        while(node != null && !obj.equals(node.getValue()))
        {
            prev = node;
            node = node.getNext();
        }
        
        if(prev == null)
        {
            head = node.getNext();
        }
        else
        {
           prev.setNext(node.getNext());
        }
    }
    
    //ex24
    public Object removeFirst()
    {
        Object temp = head.getValue();
        head = head.getNext();
        return temp;
    }
    
    //ex25
    private void fixBackLinks()
    {
        head.setPrevious(null);
        ListNode2 node = head;
        while(node != null && node.getNext() != null)
        {
            node.getNext().setPrevious(node);
            node = node.getNext();
        }
    }
    
    //ex26
    public void insertInOrder(Integer x)
    {
        ListNode2 xNode = new ListNode2(x, null, null);
        ListNode2 node = header.getNext();
        while(node != header)
        {
            if(x.compareTo(node.getValue()) > 0 && node = node.getNext())
            {
                node.getPrevious().setNext(xNode);
                xNode.setPrevious(node.getPrevious());
                node.setPrevious(xNode);
                xNode.setNext(node);
            }
        }
            
         
    }
}
    
        
