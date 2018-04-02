import smtplib
import zipfile
from email import encoders
from email.message import Message
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart  
from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText

  
def send_file_zipped(recipients, sender='jsauter@oswego.edu'):

    the_file = 'love.txt'
    #filenames= ['final/hw1//C.c', 'final/hw2/Clojure.clj','final/hw3/Haskell.hs','final/hw4/Prolog.pl','final/hw5/Python.py']    
    #with zipfile.ZipFile(zf, 'w') as myzip:
    #    for f in filenames:
    #        myzip.write(f)
    #myzip.close()  

    zf = open(the_file,'rb')

    # Create the message
    themsg = MIMEMultipart()
    #themsg['Subject'] = 'File %s' % the_file
    themsg['Subject'] = 'Jake loves Annie <3'
    themsg['To'] = ', '.join(recipients)
    themsg['From'] = sender
    themsg['Subject'] = "I love you <3"
    body = "I love you Annie <3"
    themsg.attach(MIMEText(body, 'plain'))
    themsg.preamble = 'I am not using a MIME-aware mail reader.\n'
    msg = MIMEBase('application', 'zip')
    msg.set_payload(zf.read())
    encoders.encode_base64(msg)
    msg.add_header('Content-Disposition', 'attachment', 
             filename=the_file)
    themsg.attach(msg)
    themsg = themsg.as_string()

    # send the message
    smtp = smtplib.SMTP()
    smtp.connect()
    smtp.sendmail(sender, recipients, themsg)
    smtp.close()

send_file_zipped(['areynol3@oswego.edu'])

