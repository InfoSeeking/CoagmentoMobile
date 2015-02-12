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
import android.widget.ListView;
import android.widget.AdapterView.OnItemClickListener;

public class CSpaceFragment extends Fragment{
	
	private List<CSpaceItem> itemList;
	private CSpaceItemAdapter Cadapter;
	
	private ProgressDialog progressBar;
	private Context context;
    
	String userID;
	String projectID;

	CSpaceFragment current;
	ListView list;
		
	@Override
	public void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		Bundle bundle=getArguments(); 
		userID=bundle.getString("userID");
		projectID=bundle.getString("projectID");
		context=getActivity();
	} 
	
	@Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
		View rootView=inflater.inflate(R.layout.fragment_cspace, container, false);
		list=(ListView)rootView.findViewById(R.id.cspace_list_view);
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
					itemList=XMLParser.getCSpaceItems(userID, projectID);
				} 
				catch (ParserConfigurationException e) {} 
				catch (SAXException e) {}
				catch (IOException e) {}
		
                for(int i=0;i<itemList.size();i++){
                	try {
						itemList.get(i).createImage();
					} 
                	catch (IOException e) {}
                }
				return 1;
			}
			
			@Override
			protected void onPostExecute(Object i) {
				populateCSpaceList();
				progressBar.dismiss();
			}
		};
		task.execute();
		return rootView;
    }
	
	public void populateCSpaceList(){
		Cadapter= new CSpaceItemAdapter(getActivity(),itemList);
		list.setAdapter(Cadapter);
		list.setOnItemClickListener(new OnItemClickListener(){
			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {
					String url=itemList.get(arg2).getURL(); 
					Intent intent=new Intent(getActivity(),WebpageActivity.class);
					intent.putExtra("url",url);
					startActivity(intent);
			}});
	}
}
