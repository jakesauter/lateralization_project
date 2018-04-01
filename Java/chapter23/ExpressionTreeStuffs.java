
/**
 * Jake Sauter
 * 
 * This class does stuffs
 */

import java.util.Queue;
import java.util.Stack;
import java.util.LinkedList;
public class ExpressionTreeStuffs
{
    private static Queue<TreeNode> expression;
    private static Queue<TreeNode> express;
    //     public static int eval(ExpressionTree root)
    //     {
    //         //this method evaluates and expressionTree, basicly favor bottom left, is that an algo given? -- I think in order
    //         int i, total;
    //         Queue<TreeNode> expression = new LinkedList<TreeNode>();
    //         helper(root);//sets the queue
    //         //now time to start the evaluation
    //         total = ExpressionTree.extractInt(expression.remove());
    //         while(expression.remove() != null)
    //         {
    //             if(expression.remove().getValue().toString().equals("*"))
    //             {
    //                 total += total * ExpressionTree.extractInt(expression.remove());
    //             }
    //             else
    //             {
    //                 total += total + ExpressionTree.extractInt(expression.remove());
    //             }
    //         }
    //         
    //         return total;
    //     }
    //     
    //     private static void helper(TreeNode root)
    //     {
    //         if(root != null)
    //         {
    //             helper(root.getLeft());
    //             expression.add(root);
    //             helper(root.getRight());
    //         }
    //     }
    //     public static String toInfixNotation(ExpressionTree root)
    //     {
    //         helper(root);//sets the queue
    //         String s;
    //         s = "";
    //         while(expression.remove() != null)
    //         {
    //             s += "(" + expression.remove().getValue();
    //             if(expression.remove().getValue().toString().equals("*"))
    //             {
    //                 s += "*" + expression.remove().getValue() + ")";
    //             }
    //             else
    //             {
    //                 s += "+" + expression.remove().getValue() + ")";
    //             }
    //         }
    //         return s;
    //     }
    //     public static int eval(String[] tokens)
    //     {
    //         //go from left to right saving unused operands on a stack
    //         int val, i, length;
    //         val = 0;
    //         i = 0;
    //         length = tokens.length - 1;
    //         Stack<String> operands = new Stack<String>();
    //         Queue<String> express = new LinkedList<String>();
    // 
    //         while(i < length && tokens[i] != "*" || tokens[i] != "+")
    //         {
    //             operands.push(tokens[i]);
    //         }
    //         //now the stack is full of operands, we can insert them and then evaluate the expression
    //         while(tokens[i] != null && operands.peek() != null)
    //         {
    //             express.add(operands.pop());
    //             express.add(tokens[i]);
    //         }
    // 
    //         while(express.remove() != null)
    //         {
    //             if(express.remove().equals("*"))
    //             {
    //                 val += val * Integer.parseInt(express.remove());
    //             }
    //             else
    //             {
    //                 val += val + Integer.parseInt(express.remove());
    //             }
    //         }
    // 
    //         return val;
    //     }
    //      public static ExpressionTree toExpressionTree(String[] tokens)
    //     {
    //         TreeNode root;
    //         //go from left to right saving unused operands on a stack
    //         int val, i, length, levels;
    //         val = 0;
    //         i = 0;
    //         length = tokens.length - 1;
    //         Stack<String> operands = new Stack<String>();
    //         Queue<String> express = new LinkedList<String>();
    // 
    //         while(i < length && tokens[i] != "*" || tokens[i] != "+")
    //         {
    //             operands.push(tokens[i]);
    //         }
    //         //now the stack is full of operands, we can insert them and then evaluate the expression
    //         while(tokens[i] != null && operands.peek() != null)
    //         {
    //             express.add(operands.pop());
    //             express.add(tokens[i]);
    //         }
    //         //now that we have filled the queue we can create the tree with a helper method
    //         levels = 0;
    //         i = 0;
    //         while(Math.pow(2, levels + 1) - 1 < length)
    //         {
    //             levels++;
    //         }
    //         root = TreeNode.buildFull(levels);
    //         return (ExpressionTree)(root);
    //     }

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
        int i, length;
        char ch;
        String s;
        length = tokens.length;
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

    public  static ExpressionTree buildFull(int h)
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
