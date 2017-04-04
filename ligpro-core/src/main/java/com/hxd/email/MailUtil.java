package com.hxd.email;

public class MailUtil {

	public static void sendEmail(String title,String content,String sendToEmail) {
		try {
			MailInfo mailInfo = new MailInfo();
			mailInfo.setSubject(title);
			mailInfo.setContent(content);
			mailInfo.setToAddress(sendToEmail);
			MailSender sms = new MailSender();	
			sms.sendHtmlMail(mailInfo);
			System.out.println("发送邮件完成。。。");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public static void main(String[] args) {
		try {

			System.out.println("正在发送邮件。。。");		
			MailInfo mailInfo = new MailInfo();
			mailInfo.setMailServerHost("smtp.qq.com");
			mailInfo.setMailServerPort("25");
			mailInfo.setValidate(true);
			mailInfo.setUserName("");
			mailInfo.setPassword("");// 您的邮箱密码
			mailInfo.setFromAddress("");
			mailInfo.setToAddress("");
			mailInfo.setSubject("算法任务开发清单3");
			mailInfo.setContent("算法任务开发清单3");
			String[] files = {"E:/算法任务开发清单.xlsx"};
			
			mailInfo.setAttachFileNames(files);
			
			// 这个类主要来发送邮件
			MailSender sms = new MailSender();			
			
			//sms.sendTextMail(mailInfo);// 发送文体格式
			//sms.sendHtmlMail(mailInfo);// 发送html格式;
			
			sms.sendHtmlMailWithFile(mailInfo);
			
			System.out.println("发送完成。。。");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
