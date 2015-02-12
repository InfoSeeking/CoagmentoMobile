package com.coagmento.mobile;

public class Project implements Comparable<Project>{
	
	private String projID,projName;
	
	public Project(String id, String name){
		this.projID=id;
		this.projName=name;
	}
	
	public String getProjID(){
		return this.projID;
	}
	
	public String getProjName(){
		return this.projName;
	}
	
	public String toString(){
		return this.projName;
	}
	
	@Override
	public int compareTo(Project another) {
		// TODO Auto-generated method stub
		return this.projName.compareTo(another.projName);
	}

}
