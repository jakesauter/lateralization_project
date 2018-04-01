
/**
 * Write a description of class testing123 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class testing123
{
    public static void main()
    {
        WelcomeEnglishv2 english = new WelcomeEnglishv2();
        WelcomeSpanishv2 spanish = new WelcomeSpanishv2();
        WelcomeFrenchv2 french = new WelcomeFrenchv2();
        
        System.out.println(english.gettWelcomeMessage());
        System.out.println(spanish.getWelcomeMessage());
        System.out.println(french.getWelcomeMessage());
        
    }
}
