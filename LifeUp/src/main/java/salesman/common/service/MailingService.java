package salesman.common.service;

public interface MailingService {
	Integer chkValidation(final String from, final String to);
	Integer sendMail(final String from, final String to, final String subject, final String msg, String useHtmlYn);
	Integer sendMail(final String from, final String to, final String subject, MailingMessage message);
	Integer sendMail(final String from, final String to, final String subject, MailingMessage message, String filePath, String fileNm);
	Integer sendMail(final String from, final String to, final String subject, final String msg, String filePath, String fileNm, String useHtmlYn);
}
