package com.coagmento.mobile;

import java.io.IOException;

import android.graphics.Bitmap;

public class CSpaceItem {
    
    String type;
	String title;
	String url;
	String date;
	String time;
	String bookmark;
	String thumbnail;
	Bitmap image;
	
	public CSpaceItem(String ty, String ti, String u, String d, String tim, String b, String th){
		this.type=ty;
		this.title=ti;
		this.url=u;
		this.date=d;
		this.time=tim;
		this.bookmark=b;
		this.thumbnail=th;
	}
	
	public String getType(){
		return this.type;
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
	
	public String getBookmark(){
		return this.bookmark;
	}
	
	public String getThumbnail(){
		return this.thumbnail;
	}
	
	public Bitmap getImage(){
		return this.image;
	}
	
	public void createImage() throws IOException{
		this.image=XMLParser.decodeSampledBitmapFromUrl(thumbnail, 100, 100);
	}
	
	public void destoryImage(){
		this.image=null;
	}

}
