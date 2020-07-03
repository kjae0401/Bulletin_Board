package Bulletin.Board.Util;

import java.security.MessageDigest;

public class SHA256 { 
	public static String encrypt(String planText) { 
		try{ 
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256"); 
			messageDigest.update(planText.getBytes()); 
			byte byteData[] = messageDigest.digest(); 
			
			StringBuffer stringBuffer = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) { 
				stringBuffer.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			} 
			
			StringBuffer hexString = new StringBuffer(); 
			for (int i=0;i<byteData.length;i++) { 
				String hex = Integer.toHexString(0xff & byteData[i]); 
				
				if(hex.length()==1)
					hexString.append('0');
				
				hexString.append(hex); 
			} 
			
			return hexString.toString(); 
		} catch(Exception e) { 
			throw new RuntimeException(); 
		} 
	} 
}