
/**
 * Jake Sauter
 * 
 * This class represents an ExpressionTree, I think it should represnt a node due to the arguments 
 */

import java.util.Queue;
import java.util.Stack;
import java.util.LinkedList;
public class ExpressionTree extends TreeNode
{
    public ExpressionTree(String s, TreeNode left, TreeNode right)
    {
        super(s, left, right);
    }
    
    public ExpressionTree(String s)
    {
        super(s);
    }
    
    public static void main()
    {
        //making an expression tree
        ExpressionTree node6 = new ExpressionTree("6");
        ExpressionTree node5 = new ExpressionTree("5");
        ExpressionTree node4 = new ExpressionTree("4");
        ExpressionTree node3 = new ExpressionTree("2",node4,node5);
        ExpressionTree node2 = new ExpressionTree("3",node6,null);
        ExpressionTree node1 = new ExpressionTree("1",node2,node3);
        
        //testing
        //print the tree once just to show the tree
        printInOrder((TreeNode)(node1));
        //now call all the methods and show the result in an according way
        System.out.println(extractInt(node1));
        System.out.println(eval(node1));
        //before calling toInfixNotation the tree should be printed so the change can be easily seen
        printInOrder((TreeNode)(node1));
        toInfixNotation(node1);
        printInOrder((TreeNode)(node1));
        //to test the eval(String[] tokens) method a String[] must be made
        String[] evalArray = new String[6];
        evalArray[0] = extractInt(node1) + "";
        evalArray[1] = extractInt(node2) + "";
        evalArray[2] = extractInt(node3) + "";
        evalArray[3] = extractInt(node4) + "";
        evalArray[4] = extractInt(node5) + "";
        evalArray[5] = extractInt(node6) + "";
        System.out.println(eval(evalArray));
        //now for the new Expression tree, I will print the infixed expression tree and the new one, using the same String[] for eval
        ExpressionTree root = toExpressionTree(evalArray);
        System.out.println("New ExpreesionTree");
        printInOrder((TreeNode)(root));
        System.out.println("Original ExpressionTree");
        printInOrder((TreeNode)(node1));
        
    }
    
    public static boolean isOperand(ExpressionTree node)//pick one and make it boolean
    {
        if(node.getValue().equals("*") || node.getValue().equals("+"))
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    
    public static int extractInt(ExpressionTree node)
    {
         return Integer.parseInt((String)(getValue()));
    }
    
     public static int eval(ExpressionTree root)
    {
        if(ExpressionTree.isOperand(root))
        {
            return ExpressionTree.extractInt(root);
        }
        int left, right, total;
        char ch;
        left = eval((ExpressionTree)(root.getLeft()));
        right = eval((ExpressionTree)(root.getRight()));
        ch = ((String)(root.getValue())).charAt(0);
        total = 0;
        switch(ch)
        {
            case '+': total = left + right;
            break;
            case '*': total = left * right;
            break;
        }
        return total;
    }

    public static String toInfixNotation(ExpressionTree root)
    {
        if(ExpressionTree.isOperand(root))
        {
            return (String)(root.getValue());
        }
        ExpressionTree leftroot = (ExpressionTree)(root.getLeft());
        ExpressionTree rightroot = (ExpressionTree)(root.getLeft());
        String right;
        String left = toInfixNotation(leftroot);
        right = "";
        left = "";
        if(!(ExpressionTree.isOperand(leftroot)))
        {
            right = "(" + right +  ")";
        }
        right = toInfixNotation(rightroot);
        if(!(ExpressionTree.isOperand(rightroot)))
        {
            left = "(" + left +  ")";
        }

        return left + "  " + (String)(root.getValue()) + "  " + right;
    }

    public static int eval(String[] tokens)
    {
        Stack<String> stk = new Stack<String>();
        int i, length;
        char ch;
        length = tokens.length;
        for(i = 0; i < length;i++)
        {
            ch = tokens[i].charAt(0);
            if(Character.isDigit(ch))
            {
                stk.push(tokens[i]);
            }
            int left = Integer.parseInt(stk.pop());
            int right = Integer.parseInt(stk.pop());
            switch(ch)
            {
                case '+': stk.push(String.valueOf(left + right));
                break;
                case '*': stk.push(String.valueOf(left * right));
                break;
            }
        }

        return Integer.parseInt(stk.pop());
    }

    public static ExpressionTree toExpressionTree(String[] tokens)
    {
        Stack<String> stk = new Stack<String>();
        Queue<Character> q = new LinkedList();
        ExpressionTree root;
        int i, length, levels;
        char ch;
        String s;
        length = tokens.length;
        levels = (int)(Math.sqrt((double)(length)));
        root = null;
        for(i = 0; i < length;i++)
        {
            ch = tokens[i].charAt(0);
            if(Character.isDigit(ch))
            {
                stk.push(tokens[i]);
            }
            int left = Integer.parseInt(stk.pop());
            int right = Integer.parseInt(stk.pop());
            switch(ch)
            {
                case '+': stk.push(String.valueOf(left + right));
                break;
                case '*': stk.push(String.valueOf(left * right));
                break;
            }
        }
        s = stk.pop();
        for(i = 0;i < length;i++)
        {
            q.add(s.charAt(i));
        }
        buildFull(levels);
        fillTree(root, q);
        return (ExpressionTree)(root);
    }
    
    public  static void fillTree(ExpressionTree root, Queue q)
    {
        if(root != null)
        {
            fillTree(root, TreeNode.depth(root), q);
        }
        ExpressionTree node = (ExpressionTree)(root);
        Stack<ExpressionTree> stk = new Stack<ExpressionTree>();
        while(node!=null)
        {
            if(node.getLeft()!=null&&node.getRight()!=null)
            {
                stk.push(node);
                node.setValue(null);
                node = (ExpressionTree)(node.getLeft());
            }
            else if(node.getRight()!=null)
            {
                node.setValue(null);
                node = (ExpressionTree)(node.getRight());
            }
            else if(node.getLeft()!=null)
            {
                node.setValue(null);
                node = (ExpressionTree)(node.getLeft());
            }
            else
            {
                node = stk.pop();
                node.setValue(null);
                node = (ExpressionTree)(node.getRight());
            }
        }
    }

    public static ExpressionTree buildFull(int h)
    {
        if(h == 0)
        {
            return null;
        }
        return new ExpressionTree(null,buildFull(h-1),buildFull(h-1));
    }
    
    private  static void fillTree(ExpressionTree root, int depth, Queue q)
    {
        if(depth > 0)//not the base case
        {
            //first deal with the left side
            if(root.getLeft() == null)//build a full tree on the left
            {
                root.setLeft(buildFull(depth-1));
            }
            else //fill the tree
            {
                fillTree((ExpressionTree)(root.getLeft()), depth-1, q);
            }
            //now for the right side
            if(root.getRight() == null)
            {
                root.setRight(buildFull(depth-1));
            }
            else
            {
                fillTree((ExpressionTree)(root.getRight()), depth-1, q);
            }
        }
    }
}