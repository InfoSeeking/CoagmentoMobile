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

public class CollaboratorFragment extends Fragment{ 
	
	private List<Collaborator> collalist;
	
	private ArrayAdapter<Collaborator> Cadapter;
	
	ProgressDialog progressBar;
	
	CollaboratorFragment current;
	
	Context context;
	
	ListView list;
	
	String userID;
	
	@Override
	public void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		Bundle bundle=getArguments(); 
		userID=bundle.getString("id");
		current=this;
		context=this.getActivity();
	} 
	
	@Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
		View rootView=inflater.inflate(R.layout.fragment_collaborator, container, false);
		list=(ListView)rootView.findViewById(R.id.collalist);
		
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
					collalist=XMLParser.getCollaborators(userID);
				} 
				catch (ParserConfigurationException e1) {} 
				catch (SAXException e1) {} 
				catch (IOException e1) {}
				
				return 1;
			}
			
			@Override
			protected void onPostExecute(Object i) {
				try {
					populateCollaboratorList();
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
	
	public void populateCollaboratorList() throws ParserConfigurationException, SAXException, IOException{
		
		Cadapter= new ArrayAdapter<Collaborator>(current.getActivity(),android.R.layout.simple_list_item_1,collalist);
		list.setAdapter(Cadapter);
		list.setOnItemClickListener(new OnItemClickListener(){
			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {
				String collaID=collalist.get(arg2).getId();
				Intent intent=new Intent(current.getActivity(),CollaboratorInfoActivity.class);
				intent.putExtra("collaId",collaID);
				current.startActivity(intent);
			}});
	}
	
}
