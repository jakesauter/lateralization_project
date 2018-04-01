/**
 * Jake Sauter
 * 
 * This is a class that will be used to test the TreeNode class;
 */

import java.util.Queue;
import java.util.LinkedList;

public class testClass
{
    public static void main()
    {
        TreeNode node6 = new TreeNode(6);
        TreeNode node5 = new TreeNode(5);
        TreeNode node4 = new TreeNode(4);
        TreeNode node2 = new TreeNode(2,node4,node5);
        TreeNode node3 = new TreeNode(3,node6,null);
        TreeNode node1 = new TreeNode(1,node2,node3);
        
        //testing
        System.out.println(TreeNode.isLeaf(node1));
        System.out.println(TreeNode.countPaths(node1));
        System.out.println(TreeNode.depth(node1));
        printInOrder(node1);
        System.out.println(TreeNode.sameShape(node1,node1));
        System.out.println(TreeNode.hasSameSubTree(node1,node1));
        System.out.print(TreeNode.bushRatio(node1));
        printInOrder(node1);
        TreeNode root2 = TreeNode.copy(node1);
        printInOrder(root2);
        printInOrder(node1);
        TreeNode root = TreeNode.buildFull(7);
        TreeNode.fillTree(root);
        printInOrder(root);
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
