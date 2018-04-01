package LinkedList;


/**
 * Jake Sauter
 * 
 * This is a linked list class that will hold a list of nodes
 */
public class linkedList
{
   private node root;
   private int length;
   
   public linkedList()
   {
       root = null;
       length = 0;
   }
   
   public void addElement(Object o)
   {
       if(root == null)
       {
           root = new node(o);
           System.out.println("new root created");
       }
       else
       {
           node temp = root;
           while(temp.getNext() != null)
           {
               temp = temp.getNext();
           }
           temp.setNext(new node(o));
       }
   }
   
   public void deleteElement(Object o)
   {
       node prev = null;
       node temp = root;
       while(temp.getNext() != null && !temp.getValue().equals(o))
       {
           prev = temp;
           temp = temp.getNext();
       }
       //now prev has the previous node and temp is the node we want to delete
       //or it is the last node
       if(temp.getValue().equals(o))//if we did find the node
       {
           
       }
    }
    
   public void print()
   {
       node temp;
       temp = root;
       if(root == null)
       {
           return;
       }
       System.out.print("node value: " + temp.getValue());
       while(temp.getNext() != null)
       {
           temp = temp.getNext();
           System.out.println("node value: " + temp.getValue());
       }
   }
}
