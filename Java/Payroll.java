import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.text.DecimalFormat;

public class Payroll extends JApplet
    implements ActionListener
{
  private JTextField inputHours, inputRate, display;
  private DecimalFormat money = new DecimalFormat("$0.00");

  public void init()
  {
    JPanel panel = new JPanel();
    panel.setLayout(new GridLayout(2,3));

    panel.add(new JLabel("Hours worked:"));
    panel.add(new JLabel("Hourly rate:"));
    panel.add(new JLabel("Total paycheck:"));
    
    inputHours = new JTextField(5);
    panel.add(inputHours);

    inputRate = new JTextField(5);
    panel.add(inputRate);
   
    display = new JTextField(20);
    display.setEditable(false);
    display.setBackground(Color.cyan);
    display.setText("  0");
    panel.add(display);

    JButton calc = new JButton("Calculate paycheck");
    calc.addActionListener(this);

    Container c = getContentPane();
    c.add(calc, BorderLayout.NORTH);
    c.add(panel, BorderLayout.CENTER);
  }
  public void actionPerformed(ActionEvent e)
  {
    String s;
    int hours;
    double rate, wages;

    s = inputHours.getText();
    hours = Integer.parseInt(s);
    s = inputRate.getText();
    rate = Double.parseDouble(s);
    
    if (hours <= 40)
      wages = hours * rate;
    else 
      wages = 40 * rate + (hours - 40) * 1.5 * rate;

    display.setText(money.format(wages));
  }
}