
/**
 * Write a description of class cliffstuf here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class cliffstuf
{
    public void addClimb(String peakName, int climbTime)
    {
        climbList.add(new ClimbInfo(peakName, climbTime));
    }

    public void addClimb(String peakName, int climbTime)
    {
        int i = 0;
        while (i < climbList.size() && climbList.get(i).getName().compareTo(peakName) <= 0) 
        {
            i++; 
        }
        climbList.add(i, new ClimbInfo(peakName, climbTime));
    }

    no 
    
    yes
}
