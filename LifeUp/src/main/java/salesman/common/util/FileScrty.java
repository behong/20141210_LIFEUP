package salesman.common.util;

import java.security.MessageDigest;

import org.apache.commons.codec.binary.Base64;

public class FileScrty {
    /**
     * 비밀번호를 암호화하는 기능(복호화가 되면 안되므로 MD5 인코딩 방식 적용)
     * 
     * @param String data 암호화할 비밀번호
     * @return String result 암호화된 비밀번호
     * @exception Exception
     */
    public static String encryptPassword(String data) throws Exception {
		if (data == null) {
		    return "";
		}
	
		byte[] plainText = null; // 평문
		byte[] hashValue = null; // 해쉬값
		plainText = data.getBytes();
	
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		hashValue = md.digest(plainText);
	
		return new String(Base64.encodeBase64(hashValue));
    }
}