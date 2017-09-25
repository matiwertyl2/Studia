import java.io.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.JOptionPane;


class okienko {
    JFrame frame;
    okienko () {
      this.frame=new JFrame("Edycja ksiazki");
      this.frame.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
      frame.addWindowListener(new java.awt.event.WindowAdapter() {
      @Override
      public void windowClosing(java.awt.event.WindowEvent windowEvent) {
          if (JOptionPane.showConfirmDialog(frame,
              "Are you sure to close this window?", "Really Closing?",
              JOptionPane.YES_NO_OPTION,
              JOptionPane.QUESTION_MESSAGE) == JOptionPane.YES_OPTION){
              System.exit(0);
          }
      }
      });
      Container kontener = frame.getContentPane();
      GridLayout layout = new GridLayout(4, 2);
      kontener.setLayout(layout);
      JLabel autor_etykieta = new JLabel("Autor");
      kontener.add(autor_etykieta);
      JTextField autor = new JTextField("gowno", 40);
      kontener.add(autor);
      JLabel tytuł_etykieta = new JLabel("Tytuł");
      kontener.add(tytuł_etykieta);
      JTextField tytuł = new JTextField("chuj", 40);
      kontener.add(tytuł);
      frame.pack();
      this.frame.setVisible(true);

    }
}

class proba {
  public static void main( String [] args) {
    okienko ok= new okienko();
  }
}
