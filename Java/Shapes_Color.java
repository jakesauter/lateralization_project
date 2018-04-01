/*
 * Drawing Shapes and Changing Color Example
 * 
 */
 
import java.awt.*;
import java.applet.*;

public class Shapes_Color extends Applet 
{
	public void paint(Graphics g) 
	{
		setBackground (Color.darkGray);
		
		g.setColor(Color.pink);
		g.drawRect(50, 50, 40, 40);
		
		g.setColor(Color.blue);
		g.fillRect(100, 100, 150, 150);
		
		g.setColor(Color.green);
		g.drawLine(20, 20, 300, 20);
		
		g.setColor(Color.red);
		g.fillOval(250, 250, 50, 50);
		
		g.setColor(Color.yellow);
		g.drawString("TA-DA!!!", 100, 400);
	}
}
