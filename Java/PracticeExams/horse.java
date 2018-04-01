
/**
 * Write a description of class horse here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class horse
{
    public int findHorseSpace(String name)
    {
        for (int i = 0; i < spaces.length; i++)
        {
            if (spaces[i] != null && spaces[i].getName().equals(name)) 
            {
                return i;
            }	
        }
        return -1;
    }

    public void consolidate()
    {
        Horse[] temp = new Horse[spaces.length]; 
        int j = 0;
        for (int i = 0; i < spaces.length; i++)
        {
            if (spaces[i] != null)
            {
                temp[j] = spaces[i];
                j++;
            }
        }
        spaces = temp;
    } 
}
