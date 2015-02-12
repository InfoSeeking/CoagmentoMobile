package com.coagmento.mobile;

public class WebPage {
	 
	private String title;
	private String url;
	private String date;
	private String time;
	
	public WebPage(String t, String u, String d, String ti){
		this.title=t;
		this.url=u;
		this.date=d;
		this.time=ti;
	}
	
	public String getTitle(){
		return this.title;
	}
	
	public String getURL(){
		return this.url;
	}
	
	public String getDate(){
		return this.date;
	}
	
	public String getTime(){
		return this.time;
	}
}

