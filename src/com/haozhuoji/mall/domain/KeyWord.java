package com.haozhuoji.mall.domain;

import java.io.Serializable;
/**
 * 
 * @author Chen Zhuo
 *关键字表对应javabean
 */
public class KeyWord implements Serializable{
	private static final long serialVersionUID = -1772851471934557422L;

	private Long keyWordID;
	//关键字
	private String word;
	//搜索次数
	private int count;
	public Long getKeyWordID() {
		return keyWordID;
	}
	public void setKeyWordID(Long keyWordID) {
		this.keyWordID = keyWordID;
	}
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
}
