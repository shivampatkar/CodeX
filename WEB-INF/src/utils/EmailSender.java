package utils;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;

public class EmailSender {
    public static void sendEmail(String toEmail, String subject, String message) {
        Properties props = new Properties();

        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        
        Session session = Session.getInstance(props, new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("codex2601@gmail.com", "fdymtykqsycydbmb");
            }
        });

        MimeMessage msg = new MimeMessage(session);

        try {
            msg.setFrom("codex2601@gmail.com");
            msg.setRecipients(Message.RecipientType.TO, toEmail);
            msg.setSubject(subject);
            msg.setContent(message, "text/html");

            Transport.send(msg);
        } catch(MessagingException e) {
            e.printStackTrace();
        }
    }
}