
/**
 * Write a description of class ListNodeIterator here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import java.util.NoSuchElementException;
public class ListNodeIterator implements Iterator<Object>
{
    private ListNode nextNode;
    
    public ListNodeIterator(ListNode head)
    {
        nextNode = head;
    }
    
    public boolean hasNext()
    {
        return nextNode != null;
    }
    
    public Object next()
    {
        if(nextNode == null)
        {
            throw new NoSuchElementException();
        }
        
        Object temp = nextNode.getValue();
        nextNode = nextNode.getNext();
        return temp;
    }
   
    public void remove(Object obj)
    {
        throw new UnsupportedOperationException();
    }
}
