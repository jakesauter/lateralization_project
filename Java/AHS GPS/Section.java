
/**
 * Jake Sauter
 * 
 * this object represents an array of rooms
 */
import java.util.ArrayList;
public class Section
{
   ArrayList<Integer> rooms;
   int size;
   
   public Section()
   {
      rooms = new ArrayList<Integer>();        
   }
   
   public Section(ArrayList<Integer> r)
   {
       size = rooms.size();
       int i = size, j;
       rooms = new ArrayList<Integer>(i);
       while(i!=0)
       {
           rooms.set(i,rooms.get(i));
           i--;
       }
   }
   
   public Section(ArrayList<Integer> r, int s)
   {
       size = s;
       int j, i = size;
       rooms = new ArrayList<Integer>(i);
       while(i!=0)
       {
           rooms.set(i,rooms.get(i));
           i--;
       }
   }
   
   public ArrayList<Integer> getRooms()
   {
       return rooms;
   }
   
   public void add(int roomnumber)
   {
       rooms.add(roomnumber);
       size++;
   }
}
