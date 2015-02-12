package com.coagmento.mobile;

public class Member {
	
	private String id;
	private String name;
	private String avatar;
	private String email;
	private String organization;
	
	public Member(String i, String n, String a, String e, String o){
		this.id=i;
		this.name=n;
		this.avatar=a;
		this.email=e;
		this.organization=o;
	}
	
	public String getID(){
		return this.id;
	}
	
	public String getName(){
		return this.name;
	}
	
	public String getAvatar(){
		return this.avatar;
	}
	
	public String getEmail(){
		return this.email;
	}
	
	public String getOrganization(){
		return this.organization;
	}
	
	public String toString(){
		return this.name;
	}
}
