/**
 * Jake Sauter
 * 
 * This class represnts a Tree Node in a binary tree
 */

import java.util.Queue;
import java.util.LinkedList;
import java.util.Stack;
public class TreeNode
{
    private  static Object value;
    private  static TreeNode left;
    private  static TreeNode right;
    private  static int nodeCount;
    // Constructors:

    public TreeNode(Object initValue)
    {
        value = initValue;
        left = null;
        right = null;
        nodeCount = 0;
    }

    public TreeNode(Object initValue, TreeNode initLeft, TreeNode initRight)
    {
        value = initValue;
        left = initLeft;
        right = initRight;
        nodeCount += 2;
    }

    // Methods:

    //public Object getValue() { return value; }

    public static Object getValue() { return value; }
    
    public TreeNode getLeft() { return left; }

    public TreeNode getRight() { return right; }

    public void setValue(Object theNewValue) { value = theNewValue; }

    public void setLeft(TreeNode theNewLeft) { left = theNewLeft; }

    public void setRight(TreeNode theNewRight) { right = theNewRight; }

    public static boolean isLeaf(TreeNode node)
    {
        return node != null && node.getLeft() == null && node.getRight() ==  null;
    }

    public int sumTree(TreeNode root)
    {
        if(root==null)
            return 0;
        return ((Integer)(root.getValue())).intValue() + sumTree(root.getLeft()) + sumTree(root.getRight());
    }

    public static int countPaths(TreeNode root)
    {
        if(root==null)
            return 0;

        int count = 0;
        if(root.getLeft() != null)
            count += 1 + countPaths(root.getLeft());

        if(root.getRight() != null)
            count += 1 + countPaths(root.getRight());
        return count;
    }

    public static int depth(TreeNode root)
    {
        if(root==null)
            return 0;
        else
            return Math.max(depth(root.getLeft()),depth(root.getRight()));
    }

    public static int countNodes(TreeNode root)
    {
        if(root == null)
            return 0;
        
        return 1 + countNodes(root.getLeft()) + countNodes(root.getRight());   
    }

    public static double bushRatio(TreeNode root)
    {
        if(root == null)
        {
            return 0;
        }

        return nodeCount / Math.pow(2, (depth(root) + 1) - 1);
    }

    public  static TreeNode copy(TreeNode root)
    {
        //creates a copy of any given node, what counts as a copy?
        return new TreeNode(root.getValue(), root.getLeft(), root.getRight());
    }

    public  static TreeNode mirrorImage(TreeNode root)
    {
        if(root==null)
        {
            return null;
        }
        return new TreeNode(root.getValue(),mirrorImage(root.getRight()),copy(root.getLeft()));
    }

    public static boolean sameShape(TreeNode root1, TreeNode root2)
    {
        if(root1 == null && root2 == null)
        {
            return true;
        }

        if(root1 == null && root2 == null)
        {
            return false;
        }
        else
        {
            if((root1 == null && root2 != null) || (root1 != null && root2 == null))
            {
                return false;
            }
        }
        return sameShape(root1.getLeft(), root2.getLeft()) && sameShape(root1.getRight(), root2.getRight());
    }

    public static boolean hasSameSubTree(TreeNode root1, TreeNode root2)
    {
        if(root2 == null)
        {
            return false;
        }
        else if(root1 == null)
        {
            return false;
        }
        else
        {
            return sameShape(root1.getLeft(), root2) || hasSameSubTree(root1.getRight(), root2) || hasSameSubTree(root1, root2.getRight());
        }
    }

    public  static TreeNode buildFull(int h)
    {
        if(h == 0)
        {
            return null;
        }
        return new TreeNode(null,buildFull(h-1),buildFull(h-1));
    }

    public  static void fillTree(TreeNode root)
    {
        if(root != null)
        {
            fillTree(root, depth(root));
        }
        TreeNode node = root;
        Stack<TreeNode> stk = new Stack<TreeNode>();
        while(node!=null)
        {
            if(node.getLeft()!=null&&node.getRight()!=null)
            {
                stk.push(node);
                node.setValue(null);
                node = node.getLeft();
            }
            else if(node.getRight()!=null)
            {
                node.setValue(null);
                node = node.getRight();
            }
            else if(node.getLeft()!=null)
            {
                node.setValue(null);
                node = node.getLeft();
            }
            else
            {
                node = stk.pop();
                node.setValue(null);
                node = node.getRight();
            }
        }
    }

    private  static void fillTree(TreeNode root, int depth)
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
                fillTree(root.getLeft(), depth-1);
            }
            //now for the right side
            if(root.getRight() == null)
            {
                root.setRight(buildFull(depth-1));
            }
            else
            {
                fillTree(root.getRight(), depth-1);
            }
        }

    }

    public static void printTree(TreeNode root)
    {
        TreeNode node = root;
        Queue<TreeNode> back = new LinkedList<TreeNode>();
        while(node!=null)
        {
            if(!back.isEmpty())
            {
                node = back.remove().getRight();
            }

            System.out.println(node.getValue());
            if(node.getLeft()!=null)
            {
                System.out.println(node.getLeft().getValue());
            }

            if(node.getRight()!=null)
            {
                System.out.println(node.getRight().getValue());
            }

            if(node.getLeft()!=null&&node.getRight()!=null)
            {
                back.add(node);
            }

            if(node.getLeft()!=null)
            {
                node = node.getLeft();
            }
        }
    }
    
    //for bst only
    public void traverseDecreasing(TreeNode root)
    {
        if(root != null)
        {
            traverseDecreasing(root.getRight());
            System.out.println((String)(root.getValue()));
            traverseDecreasing(root.getLeft());
        }
    }
    
    public TreeNode maxNode(TreeNode root)
    {
        if(root == null)
        {
            return null;
        }
        
        TreeNode node = root;
        while(node.getRight() != null)
        {
            node.getRight();
        }
        return node;
    }
    
    public static void printInOrder(TreeNode root)
    {
        if(root != null)
        {
            printInOrder(root.getLeft());
            System.out.print(root.getValue());
            printInOrder(root.getRight());
        }
    }
}
