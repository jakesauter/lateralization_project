package LinkedList;


/**
 * Jake Sauter
 * 
 * This will be a node class that holds a value 
 */
public class node
{
    private Object value;
    private node next;
    
    public node()
    {
        value = null;
        next = null;
    }
    
    public node(Object v)
    {
        value = v;
        next = null;
    }
    
    public Object getValue()
    {
        return value;
    }
    
    public node getNext()
    {
        return next;
    }
    
    public void setNext(node n)
    {
        next = n;
    }
    
    public void setValue(Object v)
    {
        value = v;
    }
}
