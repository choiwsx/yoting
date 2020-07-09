package org.kitchen.validation;

import java.util.UUID;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.kitchen.domain.UserVO;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class VerificationEmailSender {
	private static String from = "halympic@gmail.com";
	
	@Inject
	JavaMailSender mailSender;
	
	public void send(UserVO user, String key) {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(from);
			messageHelper.setTo(user.getEmail());
			messageHelper.setSubject("먹스타그램:주방이 준비되고있어요");
			messageHelper.setText(setContent(user.getUserNo(), key));
			mailSender.send(message);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public String setContent(Long userNo, String key) {
		String content =
				System.getProperty("line.separator")+ //한줄씩 줄간격을 두기위해 작성
	            System.getProperty("line.separator")+	                    
	            "안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다."
	            +System.getProperty("line.separator")+	  
	            "다음 링크를 눌러서 이메일을 인증하시면 회원 가입이 완료됩니다."
	            +System.getProperty("line.separator")+	    
	            "http://localhost:5050/user/verify?key="+key+"&userno="+userNo
	            +System.getProperty("line.separator")+	            
	            System.getProperty("line.separator")+	            
	            "주의:먹스타그램 가입한 적이 없다면 링크를 누르지 마세요."; 
		return content;				
	}
	
	public static String generateString() {
        String uuid = UUID.randomUUID().toString();
        uuid.replace("-", "");
        return uuid;
    }
}
