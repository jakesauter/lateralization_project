import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.text.DecimalFormat;

public class Wages extends JApplet implements ActionListener
{
  private JTextField inputHours, inputRate, display;
  private DecimalFormat money = new DecimalFormat("$0.00");

  public void init()
  {
    JPanel panel = new JPanel();
    panel.setLayout(new GridLayout(3,2));

    panel.add(new JLabel("Hours worked:"));
    inputHours = new JTextField(5);
    panel.add(inputHours);

    panel.add(new JLabel("Hourly rate:"));
    inputRate = new JTextField(5);
    panel.add(inputRate);

    panel.add(new JLabel("Total wages:"));
    display = new JTextField(20);
    display.setEditable(false);
    display.setBackground(Color.yellow);
    display.setText("  0");
    panel.add(display);

    JButton calc = new JButton("Calculate wages");
    calc.addActionListener(this);

    Container c = getContentPane();
    c.add(panel, BorderLayout.CENTER);
    c.add(calc, BorderLayout.SOUTH);   
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