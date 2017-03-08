package com.haozhuoji.mall.domain;

public class Page {
	private Integer currentPage=1;
	
	private Integer totalOption;
	
	private Integer totalPage;
	
	private Integer optionOfPage = 5;
	
	private Integer startOption;
	
	private String orderBy;
	
	private Boolean desc = false;
	public Boolean getDesc() {
		return desc;
	}

	public void setDesc(Boolean desc) {
		this.desc = desc;
	}

	public Integer getStartOption() {
		return (currentPage-1)*optionOfPage;
	}

	public void setStartOption(Integer startOption) {
		this.startOption = startOption;
	}

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		if(currentPage==null||currentPage<1){
			currentPage = 1;
		}else{			
			this.currentPage = currentPage;
		}
	}

	public Integer getTotalOption() {
		return totalOption;
	}

	public void setTotalOption(Integer totalOption) {
		totalPage = totalOption/optionOfPage;
		if(totalOption%optionOfPage!=0){			
			totalPage++;
		}
		
		if(currentPage>totalPage){
			currentPage = 1; 
		}
		this.totalOption = totalOption;
	}

	public Integer getTotalPage() {
		totalPage = totalOption/optionOfPage;
		if(totalOption%optionOfPage!=0){			
			totalPage++;
		}
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public Integer getOptionOfPage() {
		return optionOfPage;
	}

	public void setOptionOfPage(Integer optionOfPage) {
		this.optionOfPage = optionOfPage;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
}
