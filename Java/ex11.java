
/**
 * Write a description of class ex11 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class ex11
{
    public static void main()
    {
        ListNode head = new ListNode("New York", null);
        ListNode node1 = new ListNode("New Jersey", null);
        head.setNext(node1);
        ListNode node2 = new ListNode("Cali", null);
        head.setNext(node2);
        ListNode move = moveToBack(head, "New ??????");
        while(move.getNext() != null)
        System.out.println(move.getNext().getValue());
    }
    
    public static ListNode moveToBack(ListNode head, String pattern)
    {
        ListNode node = head, prev = null;
        
        while(node.getNext() != null)
        {
            Object value = node.getValue();
            String val = (String)(value);
            int valueLength = val.length();
            String before = pattern.substring(0, pattern.indexOf(" ")), after = pattern.substring(pattern.indexOf(" ") + 1);
            for(int i = 0; i < pattern.length(); i++)
            {
                //while(pattern.charAt(i) != '?')
                if(before.length() < i && val.charAt(i) != before.charAt(i))
                {
                    break;
                }
                else if(i >= pattern.indexOf(" ") && pattern.charAt(i) == '?' && after.length() < valueLength)
                {
                    ListNode tail = getTail(node);
                    tail.setNext(node);
                    tail.setValue(node.getValue());
                    prev.setNext(node.getNext());
                    prev.setValue(node.getNext().getValue());
                }
                else 
                {
                    valueLength--;
                }
            }
            prev = node;
            node = node.getNext();
        }
        return node;
    }
    
    public static ListNode getTail(ListNode head)
    {
        ListNode node = head;
        while(node.getNext() != null)
           node = node.getNext();
        ListNode tail = node.getNext();
        return tail;
    }
}
