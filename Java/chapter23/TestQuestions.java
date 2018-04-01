
/**
 * Write a description of class TestQuestions here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class TestQuestions
{
    public void accumulate(TreeNode root)
    {
        if(root == null)
        {
            return;
        }
        
        accumulate(root.getLeft());
        accumulate(root.getRight());
        int sum;
        sum = ((Integer)(root.getValue())).intValue();
        if(root.getLeft() != null)
        {
            sum += ((Integer)(root.getLeft().getValue())).intValue();
        }
        if(root.getRight() != null)
        {
            sum += ((Integer)(root.getRight().getValue())).intValue();
        }
        root.setValue(new Integer(sum));
    }
}
