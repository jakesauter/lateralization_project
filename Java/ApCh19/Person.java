public class Person implements Comparable<Person>
{
   private String firstname, lastname;
   
   public Person(String f, String l)
   {
       firstname = f;
       lastname = l;
   }
   
   public int compareTo(Person other)
   {
       int compare;
       compare = other.firstname.compareTo(firstname);
       if(compare == 0)
          compare = other.lastname.compareTo(lastname);
       return compare;
   }
   
   public String getName()
   {
       return (firstname + " " + lastname);
   }
}
