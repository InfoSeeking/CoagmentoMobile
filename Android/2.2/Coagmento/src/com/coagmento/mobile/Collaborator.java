package com.coagmento.mobile;

public class Collaborator implements Comparable<Collaborator>{
	
	private String collaID;
	private String collaName;
	
	public Collaborator(String id,String name){
		this.collaID=id;
		this.collaName=name;
	}
	
	public String getId(){
		return this.collaID;
	}
	
	public String getName(){
		return this.collaName;
	}
	
	public String toString(){
		return this.collaName;
	}
	@Override
	public int compareTo(Collaborator another) {
		// TODO Auto-generated method stub
		return this.collaName.compareTo(another.collaName);
	}

}
