public class BakersDozen implements BagelsOrderItem
{
   public BakersDouzen(double price)
   {
       super(price, 13);
   }
   
   public double getCost()
   {
       return super.getCost() - getPrice();
   }
}
