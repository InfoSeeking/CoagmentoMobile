package com.coagmento.mobile;

import java.io.IOException;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import com.coagmento.mobile.R;

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
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.AdapterView.OnItemClickListener;

public class ProjectFragment extends Fragment{
	
	private List<Project> projlist;
	
	private ArrayAdapter<Project> Padapter;
	
	ProjectFragment current;
	
	ProgressDialog progressBar;
	
	String userId;
	
	ListView list;
	
	Context context;
		
	@Override
	public void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		Bundle bundle=getArguments(); 
		userId=bundle.getString("id");
		current=this;
		context=this.getActivity();
	} 
	
	@Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
		View rootView=inflater.inflate(R.layout.fragment_project, container, false);
		list=(ListView)rootView.findViewById(R.id.projectList);
		AsyncTask<Object, Object, Object> task = new AsyncTask<Object, Object, Object>() {
			
			@Override
			protected void onPreExecute(){
				progressBar = new ProgressDialog(context);
				progressBar.setCancelable(true);
				progressBar.setIndeterminate(true);
				progressBar.show();
			}
			
			@Override
			protected Integer doInBackground(Object... params) {
				// TODO Auto-generated method stub
				try {
					projlist=XMLParser.getProjects(userId);
				} 
				catch (ParserConfigurationException e1) {} 
				catch (SAXException e1) {} 
				catch (IOException e1) {}
				
				return 1;
			}
			
			@Override 
			protected void onPostExecute(Object i) {
				try {
					populateProjectList();
				} 
				catch (ParserConfigurationException e) {} 
				catch (SAXException e) {} 
				catch (IOException e) {}
				progressBar.dismiss();
			}
		};
		task.execute();
		return rootView;
    }
	
	public void populateProjectList() throws ParserConfigurationException, SAXException, IOException{
		 
		Padapter= new ArrayAdapter<Project>(current.getActivity(),android.R.layout.simple_list_item_1,projlist);
		list.setAdapter(Padapter);
		list.setOnItemClickListener(new OnItemClickListener(){
			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {
				Intent intent=new Intent(current.getActivity(),FragmentTabsActivity.class);
				intent.putExtra("userID",current.userId);
				intent.putExtra("projectID",projlist.get(arg2).getProjID());
				current.startActivity(intent);
			}});
	}
	
}