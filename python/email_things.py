#to send an email
import smtplib
#smtpObj = smtplib.SMTP_SSL('smtp.gmail.com', 465)
#smtpObj.ehlo()
#smtpObj.login('jsauter@oswego.edu', ' Oswego18')
#smtpObj.sendmail('jsauter@oswego.edu', 'jake.sauter3@gmail.com', 'Subject: So long.\nDear Alice, so long and thanks for all the fish. Sincerely, Bob')
#smtpObj.quit()

#to recieve an email
import imapclient
import pyzmail
imapObj = imapclient.IMAPClient('imap.gmail.com', ssl=True)
imapObj.login('jsauter@oswego.edu', 'Oswego18')
imapObj.select_folder('INBOX', readonly=False)
# if we want emails to get marked as read, then set readonly to false
UIDs = imapObj.search('FROM no-reply@researchgatemail.net')
print "UIDs: ", UIDs
for uid in UIDs: 
    rawMessages = imapObj.fetch([UIDs[uid]], ['BODY[]', 'FLAGS'])
    message = pyzmail.PyzMessage.factory(rawMessages[UIDs[uid]]['BODY[]'])
    # to delete emails
    imapObj.delete_messages(UIDs)
    imapObj.expunge()
    message.get_subject()
    print "email from", message.get_addresses('from'), "deleted"
    #message.get_addresses('to')
    #message.get_addresses('cc')
    #message.get_addresses('bcc')
    #message.text_part != None
    #message.text_part.get_payload().decode(message.text_part.charset)
imapObj.logout()
