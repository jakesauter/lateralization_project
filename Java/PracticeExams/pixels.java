
/**
 * Write a description of class pixels here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class pixels
{
    public int countWhitePixels()
    {
        int count = 0;
        for (int r = 0; r < pixelValues.length; r++)
        {
            for (int c = 0; c < pixelValues[0].length; c++)
            {
                if (pixelValues[r][c] == WHITE) 
                {
                    count++;
                }
            }
        }
        return count;
    }

    public void processImage()
    {
        for (int r = 0; r < pixelValues.length - 2; r++)
        {
            for (int c = 0; c < pixelValues[0].length - 2; c++)
            {
                pixelValues[r][c] = Math.max(BLACK, pixelValues[r][c] - pixelValues[r+2][c+2]);
            }
        }
    } 
}
