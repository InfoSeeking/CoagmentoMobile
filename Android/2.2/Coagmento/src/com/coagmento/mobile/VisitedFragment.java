package com.coagmento.mobile;

import java.io.IOException;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;

public class VisitedFragment extends Fragment{

	List<WebPage> vPages;
	ListView visitedList;
	WebItemAdapter Vadapter;
	
	String projectID;
	Context context;
	ProgressDialog progressBar;
	@Override
	public void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		Bundle bundle=getArguments(); 
		projectID=bundle.getString("projectID");
		context=getActivity();
	} 
	
	@Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
		 View rootView=inflater.inflate(R.layout.fragment_visited, container, false);
		 visitedList=(ListView)rootView.findViewById(R.id.visitedlist);
		 AsyncTask<Object, Object, Object> task = new AsyncTask<Object, Object, Object>() {
			 	@Override
				protected void onPreExecute(){
					progressBar = new ProgressDialog(context);
					progressBar.setCancelable(true);
					progressBar.setIndeterminate(true);
					progressBar.show();
				}
				@Override
				protected Object doInBackground(Object... params) {
					// TODO Auto-generated method stub
					try {
						vPages=XMLParser.getVisitedPages(projectID);
					} 
					catch (ParserConfigurationException e) {} 
					catch (SAXException e) {} 
					catch (IOException e) {}
					return null;
				}
				
				@Override
				protected void onPostExecute(Object o){
					populateVisitedList();
					progressBar.dismiss();
				}
				 
			 };
			 task.execute();
	     return rootView;
    }
    
	public void populateVisitedList(){
		Vadapter=new WebItemAdapter(getActivity(),vPages);
		visitedList.setAdapter(Vadapter);
		visitedList.setOnItemClickListener(new OnItemClickListener(){
			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {
					String url=vPages.get(arg2).getURL();
					Intent intent=new Intent(getActivity(),WebpageActivity.class);
					intent.putExtra("url",url);
					startActivity(intent);
			}});
	}

}
