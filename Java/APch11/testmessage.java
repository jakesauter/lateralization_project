
/**
 * Write a description of class testmessage here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class testmessage
{
    public static void main()
    {
        /**
        WelcomeMessage english = new WelcomeEnglish();
        WelcomeMessage spanish = new WelcomeSpanish();
        WelcomeMessage french = new WelcomeFrench();
        
        print(english);
        print(spanish);
        print(french);
        **/
        testmessage test = new testmessage();
        print(new WelcomeEnglish());
        print(new WelcomeSpanish());
        print(new WelcomeFrench());
    }
    
    public static void print(WelcomeMessage message)
    {
        System.out.println(message.getWelcomeMessage());
    }
}
