
/**
 * Jake Sauter
 * 
 * This program will get me a valentines day date.
 */

import javax.swing.*;

public class hey
{
   public static void main()
   {
        String answer = "";
        answer = JOptionPane.showInputDialog(null,"Are you spontaneous?");
        if(answer.equals("yes"))
        {
            answer = JOptionPane.showInputDialog(null,"Do you think i'm cute?");
            if(answer.equals("yes"))
            {
                answer = JOptionPane.showInputDialog(null,"What are you doing on valentines day?");
                if(answer.equals("nothing"))
                {
                    answer = JOptionPane.showInputDialog(null,"well now you're not");
                    if(answer.equals("okay :)"))
                    {
                        JOptionPane.showMessageDialog(null, "dope.");
                    }
                }
                else
                {
                    JOptionPane.showInputDialog(null,"well this didn't work");
                }
            }
            else
            {
                JOptionPane.showInputDialog(null,"well this didn't work");
            }
        }
        else
        {
            JOptionPane.showInputDialog(null,"well this didn't work");
        }
   }
}
