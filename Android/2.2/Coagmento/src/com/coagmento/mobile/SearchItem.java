package com.coagmento.mobile;

public class SearchItem implements Comparable<SearchItem>{
	
	private String query;
	private String source;
	private String url;
	private String date;
	private String time;
	
	public SearchItem(String q, String s, String u, String d, String t){
		this.query=q;
		this.source=s;
		this.url=u;
		this.date=d;
		this.time=t;
	}
	
	public String toString(){
		return query;
	}
	
	public String getQuery(){
		return this.query;
	}
	
	public String getSource(){
		return this.source;
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

	@Override
	public int compareTo(SearchItem another) {
		return this.query.compareTo(another.getQuery());
	}
}
