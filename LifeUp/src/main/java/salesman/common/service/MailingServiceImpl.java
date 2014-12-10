package salesman.common.service;

import java.io.File;

import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailingServiceImpl implements MailingService {
	
	private JavaMailSender mailSender;  

    public void setMailSender(JavaMailSender mailSender) {  
        this.mailSender = mailSender;  
    }

    public Integer chkValidation(final String from, final String to) {
		if(from == null || from.equals(""))
			return -1;
		else if (to == null || to.equals(""))
			return -2;
		
		return 0;
    }

	public Integer sendMail(final String from, final String to, final String subject, final String msg, String useHtmlYn) {
		return sendMail(from, to, subject, msg, "", "", useHtmlYn);
	}

	public Integer sendMail(final String from, final String to, final String subject, MailingMessage message) {		
		if(message.useHtml())
			return sendMail(from, to, subject, message.getHtmlContent(), "", "", "Y");
		else
			return sendMail(from, to, subject, message.getTextContent(), "", "", "N");
	}
	
	public Integer sendMail(final String from, final String to, final String subject, MailingMessage message, 
			String filePath, String fileNm) {
		
		if(message.useHtml())
			return sendMail(from, to, subject, message.getHtmlContent(), filePath, fileNm, "Y");
		else
			return sendMail(from, to, subject, message.getTextContent(), filePath, fileNm, "N");				
	}
		
	public Integer sendMail(final String from, final String to, final String subject, final String msg, String filePath, String fileNm, String useHtmlYn) {
		boolean bFileExists = false;
		FileSystemResource file = null;
		
		int result = chkValidation(from, to);		
		if(result < 0)
			return result;
		
        try {
        	File attachedFile = new File(filePath + "/" + fileNm);        	
        	if(attachedFile.exists() && attachedFile.isFile()) {	        	
	        	bFileExists = true;
		        file = new FileSystemResource(attachedFile);  
	        }
        	
	        MimeMessage message = mailSender.createMimeMessage();  	  	  
	        MimeMessageHelper helper = new MimeMessageHelper(message, bFileExists, "UTF-8");
	        helper.setFrom(from);  
	        helper.setTo(to);  
	        helper.setSubject(MimeUtility.encodeText(subject, "EUC-KR", "B"));  
	        
	        if(useHtmlYn.equals("Y"))
	        	message.setContent(msg, "text/html; charset=EUC-KR");
	        else
	        	helper.setText(MimeUtility.encodeText(msg, "EUC-KR", "B"));	  
	   
	        if(bFileExists)
	        	helper.addAttachment(new String(fileNm.getBytes("UTF-8"), "8859_1"), file);
	        
	        mailSender.send(message);
	        
	        return 0;
        } catch(Exception e) {
        	e.printStackTrace();        	
        	return -9;
        }  
    }  
}