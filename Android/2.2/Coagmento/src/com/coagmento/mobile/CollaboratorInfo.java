package com.coagmento.mobile;

public class CollaboratorInfo {
	
	private String avatar;
	private String username;
	private String email;
	private String organization;
	private String website;
	
	public CollaboratorInfo(String a,String u,String e,String o,String w){
		this.avatar=a;
		this.username=u;
		this.email=e;
		this.organization=o;
		this.website=w;
	}
	
	public String getImage(){
		return this.avatar;
	}
	
	public String getUsername(){
		return this.username;
	}
	
	public String getEmail(){
		return this.email;
	}
	
	public String getOrganization(){
		return this.organization;
	}
	
	public String getWebsite(){
		return this.website;
	}
}
