public class BagelsOrderItem implements OrderItem
{
   private double price;
   private int quantity;
   
   public BagelsOrderItem(double pr, int qty)
   {
       price = pr;
       quantity = qty;
   }
   
   public int getQuantity()
   {
       return quantity;
   }
   
   public doulble getPrice()
   {
       return price;
   }
   
   public double getCost()
   {
       return price * quantity;//Question: why in the book do they use the accessors?
   }
}
