public class methodstuffs
{
    public int getAwardLevel()
    {
        int count, sum, grade, award;
        double avg;
        count = 0;
        sum = 0;
        for(Exam e : exams)
        {
            grade = e.getGrade();
            if(grade >= 3)
            {
                count++;
            }
            sum += grade;
        }
        
        avg = (double)sum / exams.size();
        
        if(count >= 5 && avg >= 3.25)
        {
            award = 3;
        }
        else if(count >= 4 && avg >= 3.25)
        {
            award = 2;
        }
        else if(count >= 3)
        {
            award = 1;
        }
        else
        {
            award = 0;
        }
        
        return award;
    }
    
    public static double[] getStats(List<APStudent> list)
    {
        double[] percent = new double[4];
        int[] counts = new int[4];
        int award;
        
        for(APStundent s : list)
        {
            award = s.getAwardLevel();
            counts[award]++;
        }
        
        for(award = 0; award <= 3; award++)
        {
            percent[award] = 100.0 * (double)count[award] / list.size();
        }
        
        return percent;
    }
    
    public void reserve(int k, int timeSlot)
    {
        String s = schedules.get(k);
        schedules.set(k, s.substing(0, timeSlot) + "xxx" + s.substring(timeSlot + 3));
    }
    
    public int occupiedSlots(int k)
    {
        String s = scedules.get(k);
        int count = 0, t;
        
        for(t = 0; t < s.length(); t++)
        {
            if(s.substring(t, t+1).equals("x"))
            {
                count++;
            }
        }
        
        return count;
    }
    
    public int findTable(int timeSlot)
    {
        int bestTable = 0, mostOccupiedSlots = -1, k, x;
        String s;
        
        for(k = 1; k < schedules.size(); k++)
        {
            s = schedules.get(k);
            if(s.substring(timeSlot, timeSlot + 3).equals(" . . . "))
            {
                x = occupiedSlots(k);
                if(x > mostOccupiedSlots)
                {
                    bestTable = k;
                    mostOccupiedSlots = x;
                }
            }
        }
        
        return bestTable;
    }
}