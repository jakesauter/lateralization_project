import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.applet.*;

public class Morning extends JApplet
  implements ActionListener
{
  private AudioClip rooster, cow;
  private int toggleState = -1;

  public void init()
  {
    rooster = getAudioClip(getDocumentBase(), "roost.wav");
    cow = getAudioClip(getDocumentBase(), "moo.wav");

    Container c = getContentPane();
    c.setBackground(Color.black);

    Timer t = new Timer(5000, this);
    t.start();
  }

  public void actionPerformed(ActionEvent e)
  {

    Container c = getContentPane();
    if (toggleState < 0)
    {
      rooster.play();
      c.setBackground(Color.white);
    }
    else
    {
      cow.play();
      c.setBackground(Color.black);
    }
    toggleState = -toggleState;
  }
}

