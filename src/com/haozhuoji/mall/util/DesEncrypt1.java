package com.haozhuoji.mall.util;


import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

/**
 * 
 * 使用DES加密与解密,可对byte[],String类型进行加密与解密 密文可使用String,byte[]存储.
 * 
 * 方法: void getKey(String strKey)从strKey的字条生成一个Key
 * 
 * String getEncString(String strMing)对strMing进行加密,返回String密文 String
 * getDesString(String strMi)对strMin进行解密,返回String明文
 * 
 * byte[] getEncCode(byte[] byteS)byte[]型的加密 byte[] getDesCode(byte[]
 * byteD)byte[]型的解密
 */

public class DesEncrypt1 {
	private SecretKey key;
	public DesEncrypt1(String key) throws Exception{
		key = java.net.URLEncoder.encode(key, "UTF-8");
		KeyGenerator _generator = KeyGenerator.getInstance("DES");
		_generator.init(new SecureRandom(key.getBytes()));
		this.key = _generator.generateKey();
		_generator = null;
	}

	/**
	 * 加密String明文输入,String密文输出
	 * 
	 * @param strMing
	 * @return
	 * @throws Exception 
	 */
	public String getEncString(String strMing) throws Exception {
		byte[] byteMi = null;
		byte[] byteMing = null;
		String strMi = "";
		return byte2hex(getEncCode(strMing.getBytes()));
	}

	/**
	 * 解密 以String密文输入,String明文输出
	 * 
	 * @param strMi
	 * @return
	 * @throws Exception
	 */
	public String getDesString(String strMi) throws Exception {
		byte[] byteMing = null;
		byte[] byteMi = null;
		String strMing = "";
		return new String(getDesCode(hex2byte(strMi.getBytes())));
	}

	/**
	 * 加密以byte[]明文输入,byte[]密文输出
	 * 
	 * @param byteS
	 * @return
	 * @throws Exception 
	 */
	private byte[] getEncCode(byte[] byteS) throws Exception {
		byte[] byteFina = null;
		Cipher cipher;
		cipher = Cipher.getInstance("DES");
		cipher.init(Cipher.ENCRYPT_MODE, key);
		byteFina = cipher.doFinal(byteS);
		return byteFina;
	}

	/**
	 * 解密以byte[]密文输入,以byte[]明文输出
	 * 
	 * @param byteD
	 * @return
	 * @throws Exception 
	 */
	private byte[] getDesCode(byte[] byteD) throws Exception {
		Cipher cipher;
		byte[] byteFina = null;
		cipher = Cipher.getInstance("DES");
		cipher.init(Cipher.DECRYPT_MODE, key);
		byteFina = cipher.doFinal(byteD);

		return byteFina;
	}

	/**
	 * 二行制转字符串
	 * 
	 * @param b
	 * @return
	 */
	private String byte2hex(byte[] b) { // 一个字节的数，
		// 转成16进制字符串
		String hs = "";
		String stmp = "";
		for (int n = 0; n < b.length; n++) {
			// 整数转成十六进制表示
			stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));
			if (stmp.length() == 1)
				hs = hs + "0" + stmp;
			else
				hs = hs + stmp;
		}
		return hs.toUpperCase(); // 转成大写
	}

	private byte[] hex2byte(byte[] b) {
		if ((b.length % 2) != 0)
			throw new IllegalArgumentException("长度不是偶数");
		byte[] b2 = new byte[b.length / 2];
		for (int n = 0; n < b.length; n += 2) {
			String item = new String(b, n, 2);
			// 两位一组，表示一个字节,把这样表示的16进制字符串，还原成一个进制字节
			b2[n / 2] = (byte) Integer.parseInt(item, 16);
		}
		return b2;
	}
}