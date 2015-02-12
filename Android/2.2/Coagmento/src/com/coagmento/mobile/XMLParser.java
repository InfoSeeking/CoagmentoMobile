package com.coagmento.mobile;

import java.io.IOException;
import java.net.URL;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

public class XMLParser {
	
	public static int Connect(LoginActivity activity,String username,String password) throws IOException, ParserConfigurationException, SAXException{
		String loginRequest="http://coagmento.org/mobile/login.php?";
		String urlParameters="userName="+username+"&password="+password;
		
		Document doc=XMLParser.parse(loginRequest+urlParameters);
	    NodeList nl=doc.getElementsByTagName("login"); 
	    Node loginTag=nl.item(0);     //There is only one node with the tag <login>
	    
	    Node IDTag=loginTag.getFirstChild(); // userID tag from the xml response
	    String id=IDTag.getTextContent();    //String contents in userID tag
	    
	    if(id.equals("0")){       // "0" and "Invalid" are the response when attempting 
	    	  return -1;          //to login in with wrong username and/or password
	    }
	    activity.setUserId(id);
		return 1;
	}
	
	public static List<Project> getProjects(String userID) throws ParserConfigurationException, SAXException, IOException{
		List<Project> projList=new LinkedList<Project>();
		
		String projRequest="http://coagmento.org/mobile/projList.php?";
		String urlParameters="userID="+userID;
		Document doc=XMLParser.parse(projRequest+urlParameters);
	    
	    NodeList nl=doc.getElementsByTagName("project");
	    for(int i=0;i<nl.getLength();i++){
	    	System.out.println(i);
	    	Node project=nl.item(i);
	    	Node projIDTag=project.getFirstChild();
	    	Node projNameTag=project.getLastChild();
	    	Project newProj=new Project(projIDTag.getTextContent(),projNameTag.getTextContent());
	    	projList.add(newProj);
	    }
	    Collections.sort(projList);
		return projList;
	}
	
	public static List<Collaborator> getCollaborators(String userID) throws ParserConfigurationException, SAXException, IOException{
		
		List<Collaborator> colList=new LinkedList<Collaborator>();
		
		String colRequest="http://coagmento.org/mobile/collabList.php?";
		String urlParameters="userID="+userID;
		Document doc=XMLParser.parse(colRequest+urlParameters);
	    
	    NodeList nl=doc.getElementsByTagName("collaborator");
	    
	    for(int i=0;i<nl.getLength();i++){
	    	Node colla=nl.item(i);
	    	Node collaIDTag=colla.getFirstChild();
	    	Node collaNameTag=colla.getLastChild();
	    	Collaborator newColla=new Collaborator(collaIDTag.getTextContent(),collaNameTag.getTextContent());
	    	colList.add(newColla);
	    }
	    Collections.sort(colList);
		return colList;
	}
	
	public static CollaboratorInfo getCollaInfo(String collaID) throws ParserConfigurationException, SAXException, IOException{
		
		String infoRequest="http://coagmento.org/mobile/getUser.php?";
		String urlParameters="userID="+collaID;
		Document doc=XMLParser.parse(infoRequest+urlParameters);
	    
	    NodeList nl;
	    
	    nl=doc.getElementsByTagName("avatar");
	    String avatar=nl.item(0).getTextContent();
	    
	    nl=doc.getElementsByTagName("userName");
	    String username=nl.item(0).getTextContent();
	    
	    nl=doc.getElementsByTagName("email");
	    String email=nl.item(0).getTextContent();
	    
	    nl=doc.getElementsByTagName("organization");
	    String organization=nl.item(0).getTextContent();
	    
	    nl=doc.getElementsByTagName("website");
	    String website=nl.item(0).getTextContent();
	    
	    CollaboratorInfo info=new CollaboratorInfo(avatar,username,email,organization,website);
		return info; 
	}
	
	public static List<SearchItem> getSearchItems(String projId) throws ParserConfigurationException, SAXException, IOException{
		
		String searchRequest="http://coagmento.org/mobile/getSearches.php?";
		String urlParameters="projID="+projId;
		Document doc=XMLParser.parse(searchRequest+urlParameters);
		
		List<SearchItem> sl=new LinkedList<SearchItem>();
		
		NodeList nl=doc.getElementsByTagName("search");
		
		for(int i=0;i<nl.getLength();i++){
			Node item=nl.item(i);
			Node nullTag=item.getFirstChild();
			Node queryTag=nullTag.getNextSibling();
				 nullTag=queryTag.getNextSibling();
			Node sourceTag=nullTag.getNextSibling();
				 nullTag=sourceTag.getNextSibling();
			Node urlTag=nullTag.getNextSibling();
				 nullTag=urlTag.getNextSibling();
			Node dateTag=nullTag.getNextSibling();
				 nullTag=dateTag.getNextSibling();
			Node timeTag=nullTag.getNextSibling();
			String q=queryTag.getTextContent();
			String s=sourceTag.getTextContent();
			String u=urlTag.getTextContent();
			String d=dateTag.getTextContent();
			String t=timeTag.getTextContent();
			SearchItem newItem=new SearchItem(q,s,u,d,t);
			sl.add(newItem);
		}
		Collections.sort(sl);
		return sl;
	}
	
	public static List<CSpaceItem> getCSpaceItems(String userID,String projID) throws ParserConfigurationException, SAXException, IOException{
		String searchRequest="http://coagmento.org/mobile/getCSpace.php?";
		String urlParameters="userID="+userID+"&projID="+projID;
		Document doc=XMLParser.parse(searchRequest+urlParameters);
		List<CSpaceItem> cl=new LinkedList<CSpaceItem>();
		
		NodeList nl=doc.getElementsByTagName("item");
		
		for(int i=0;i<nl.getLength();i++){
			Node item=nl.item(i);
			Node nullTag=item.getFirstChild();
			Node typeTag=nullTag.getNextSibling();
			nullTag=typeTag.getNextSibling();
			Node titleTag=nullTag.getNextSibling();
			nullTag=titleTag.getNextSibling();
			Node urlTag=nullTag.getNextSibling();
			nullTag=urlTag.getNextSibling();
			Node dateTag=nullTag.getNextSibling();
			nullTag=dateTag.getNextSibling();
			Node timeTag=nullTag.getNextSibling();
			nullTag=timeTag.getNextSibling();
			Node bookmarkTag=nullTag.getNextSibling();
			nullTag=bookmarkTag.getNextSibling();
			Node thumbnailTag=nullTag.getNextSibling();
			String ty=typeTag.getTextContent();
			String ti=titleTag.getTextContent();
			String u=urlTag.getTextContent();
			String d=dateTag.getTextContent();
			String tim=timeTag.getTextContent();
			String b=bookmarkTag.getTextContent();
			String th=thumbnailTag.getTextContent();
			System.out.println(th);
			CSpaceItem newItem=new CSpaceItem(ty,ti,u,d,tim,b,th);
			cl.add(newItem);
		}
		return cl;
	}
	
	public static List<WebPage> getVisitedPages(String projId) throws ParserConfigurationException, SAXException, IOException{
		
		String searchRequest="http://coagmento.org/mobile/getVisited.php?";
		String urlParameters="projID="+projId;
		Document doc=XMLParser.parse(searchRequest+urlParameters);
		List<WebPage> vl=new LinkedList<WebPage>();
		NodeList nl=doc.getElementsByTagName("webpage");
		for(int i=0;i<nl.getLength();i++){
			Node item=nl.item(i);
			Node nullTag=item.getFirstChild();
			Node titleTag=nullTag.getNextSibling();
			nullTag=titleTag.getNextSibling();
			Node urlTag=nullTag.getNextSibling();
			nullTag=urlTag.getNextSibling();
			Node dateTag=nullTag.getNextSibling();
			nullTag=dateTag.getNextSibling();
			Node timeTag=nullTag.getNextSibling();
			String ti=titleTag.getTextContent();
			String u=urlTag.getTextContent();
			String d=dateTag.getTextContent();
			String tim=timeTag.getTextContent();
			WebPage newItem=new WebPage(ti,u,d,tim);
			vl.add(newItem);
		}
		return vl;
	}
	
	public static List<WebPage> getBookmarkedPages(String projId) throws ParserConfigurationException, SAXException, IOException{
		
		String searchRequest="http://coagmento.org/mobile/getBookmarks.php?";
		String urlParameters="projID="+projId;
		Document doc=XMLParser.parse(searchRequest+urlParameters);
		List<WebPage> bl=new LinkedList<WebPage>();
		NodeList nl=doc.getElementsByTagName("bookmark");
		for(int i=0;i<nl.getLength();i++){
			Node item=nl.item(i);
			Node nullTag=item.getFirstChild();
			Node titleTag=nullTag.getNextSibling();
			nullTag=titleTag.getNextSibling();
			Node urlTag=nullTag.getNextSibling();
			nullTag=urlTag.getNextSibling();
			Node dateTag=nullTag.getNextSibling();
			nullTag=dateTag.getNextSibling();
			Node timeTag=nullTag.getNextSibling();
			String ti=titleTag.getTextContent();
			String u=urlTag.getTextContent();
			String d=dateTag.getTextContent();
			String tim=timeTag.getTextContent();
			WebPage newItem=new WebPage(ti,u,d,tim);
			bl.add(newItem);
		}
		return bl;
	}

	public static List<WebPage> getSnippets(String projId) throws ParserConfigurationException, SAXException, IOException{
	
		String searchRequest="http://coagmento.org/mobile/getSnippets.php?";
		String urlParameters="projID="+projId;
		Document doc=XMLParser.parse(searchRequest+urlParameters);
		List<WebPage> sl=new LinkedList<WebPage>();
		NodeList nl=doc.getElementsByTagName("snippet");
		for(int i=0;i<nl.getLength();i++){
			Node item=nl.item(i);
			Node nullTag=item.getFirstChild();
			Node titleTag=nullTag.getNextSibling();
			nullTag=titleTag.getNextSibling();
			Node urlTag=nullTag.getNextSibling();
			nullTag=urlTag.getNextSibling();
			Node dateTag=nullTag.getNextSibling();
			nullTag=dateTag.getNextSibling();
			Node timeTag=nullTag.getNextSibling();
			Node contentTag=timeTag.getNextSibling();
			nullTag=contentTag.getNextSibling();
			Node nodeTag=nullTag.getNextSibling();
			String ti=titleTag.getTextContent();
			String u=urlTag.getTextContent();
			String d=dateTag.getTextContent();
			String tim=timeTag.getTextContent();
			String c=contentTag.getTextContent();
			String n=nodeTag.getTextContent();
			WebPage newItem=new Snippet(ti,u,d,tim,c,n);
			sl.add(newItem);
		}
		return sl;
	}

	public static List<WebPage> getAnnotations(String projId) throws ParserConfigurationException, SAXException, IOException{
	
		String searchRequest="http://coagmento.org/mobile/getAnnotations.php?";
		String urlParameters="projID="+projId;
		Document doc=XMLParser.parse(searchRequest+urlParameters);
		List<WebPage> al=new LinkedList<WebPage>();
		NodeList nl=doc.getElementsByTagName("annotation");
		for(int i=0;i<nl.getLength();i++){
			Node item=nl.item(i);
			Node nullTag=item.getFirstChild();
			Node titleTag=nullTag.getNextSibling();
			nullTag=titleTag.getNextSibling();
			Node urlTag=nullTag.getNextSibling();
			nullTag=urlTag.getNextSibling();
			Node dateTag=nullTag.getNextSibling();
			nullTag=dateTag.getNextSibling();
			Node timeTag=nullTag.getNextSibling();
			String ti=titleTag.getTextContent();
			String u=urlTag.getTextContent();
			String d=dateTag.getTextContent();
			String tim=timeTag.getTextContent();
			WebPage newItem=new WebPage(ti,u,d,tim);
			al.add(newItem);
		}
		return al;
	}
	
	public static List<Member> getMembers(String projectID) throws ParserConfigurationException, SAXException, IOException{
		String searchRequest="http://coagmento.org/mobile/getMembers.php?";
		String urlParameters="projID="+projectID;
		Document doc=XMLParser.parse(searchRequest+urlParameters);
		List<Member> ml=new LinkedList<Member>();
		NodeList nl=doc.getElementsByTagName("member");
		for(int i=0;i<nl.getLength();i++){
			Node item=nl.item(i);
			Node idTag=item.getFirstChild();
			Node nameTag=idTag.getNextSibling();
			Node avatarTag=nameTag.getNextSibling();
			Node emailTag=avatarTag.getNextSibling();
			Node organizationTag=emailTag.getNextSibling();
			String id=idTag.getTextContent();
			String name=nameTag.getTextContent();
			String avatar=avatarTag.getTextContent();
			String email=emailTag.getTextContent();
			String organization=organizationTag.getTextContent();
			Member newItem=new Member(id,name,avatar,email,organization);
			ml.add(newItem);
		}
		return ml;
	}
	
	public static Document parse(String u) throws ParserConfigurationException, SAXException, IOException{
		URL url=new URL(u);
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	    DocumentBuilder builder = factory.newDocumentBuilder();
	    Document doc = builder.parse(url.openStream());
	    return doc;
	}
	
	public static Bitmap decode(String url) throws IOException{
		URL newurl=new URL(url);
		Bitmap bm=BitmapFactory.decodeStream(newurl.openConnection().getInputStream()); 
		return bm;
	}
	
	public static Bitmap decodeSampledBitmapFromUrl(String url, 
	        int reqWidth, int reqHeight) throws IOException {
		URL newurl=new URL(url);
	    // First decode with inJustDecodeBounds=true to check dimensions
	    final BitmapFactory.Options options = new BitmapFactory.Options();
	    options.inJustDecodeBounds = true;
	    BitmapFactory.decodeStream(newurl.openConnection().getInputStream(),null,options);

	    // Calculate inSampleSize
	    options.inSampleSize = calculateInSampleSize(options, reqWidth, reqHeight);

	    // Decode bitmap with inSampleSize set
	    options.inJustDecodeBounds = false;
	    return BitmapFactory.decodeStream(newurl.openConnection().getInputStream(), null, options);
	}
	
	private static int calculateInSampleSize(
            BitmapFactory.Options options, int reqWidth, int reqHeight) {
 
		final int height = options.outHeight;
		final int width = options.outWidth;
		int inSampleSize = 1;

		if (height > reqHeight || width > reqWidth) {

			final int halfHeight = height / 2;
			final int halfWidth = width / 2;
			
			while ((halfHeight / inSampleSize) > reqHeight
					&& (halfWidth / inSampleSize) > reqWidth) {
				inSampleSize *= 2;
			}
		}
    	return inSampleSize;
	}
}
