
/**
 * Write a description of class s here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class twentyelevennumberfour
{
    private void fillBlock(String str)
    {
        int i = 0;

        for (int r = 0; r < numRows; r++)
        {
            for (int c = 0; c < numCols; c++)
            {
                if (i < str.length())
                    letterBlock[r][c] = str.substring(i, i+1);
                else
                    letterBlock[r][c] = "A";
                i++;
            }
        }
    }

    public String encryptMessage(String message)
    {
        String code = "";
        while (message.length() > 0)
        {
            int n = numRows * numCols;
            if (n > message.length())
                n = message.length(); 
            fillBlock(message.substring(0, n)); 

            code += encryptBlock();
            message = message.substring(n);
        }

        return code;
    }
}
