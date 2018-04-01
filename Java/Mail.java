import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.text.DecimalFormat;

public class Mail extends JApplet 
   implements ActionListener
{
  private JTextField inputLbs, inputOzs, postage;
  private JRadioButton firstClass, priority;
  private DecimalFormat money = new DecimalFormat("$0.00");

  public void init()
  {
    Container c = getContentPane();
    c.setLayout(new FlowLayout());
    c.add(new JLabel("Lbs:"));
    inputLbs = new JTextField(5);
    c.add(inputLbs);
    c.add(new JLabel("Ounces:"));
    inputOzs = new JTextField(5);
    c.add(inputOzs);
    firstClass = new JRadioButton("First class", true);
    priority = new JRadioButton("Priority");
    ButtonGroup gr = new ButtonGroup();
    gr.add(firstClass);
    gr.add(priority);
    c.add(firstClass);
    c.add(priority);
    JButton calc = new JButton("Calculate Postage");
    calc.addActionListener(this); 
    c.add(calc);
    postage = new JTextField(6);
    postage.setEditable(false);
    postage.setBackground(Color.yellow);
    c.add(postage);
  }

  public void actionPerformed(ActionEvent e)
  {
    String s;
    char mailType;
    int oz = 0;
    double amt;
    
    s = inputLbs.getText().trim();
    if (s.length() > 0)
      oz += 16 * Integer.parseInt(s);
    
    s = inputOzs.getText().trim();
    if (s.length() > 0)
      oz += Integer.parseInt(s);

    if (firstClass.isSelected())
      amt = oz * 0.35;
    else 
      amt = 3.00 + oz * 0.62;

    postage.setText(money.format(amt));
  }
}