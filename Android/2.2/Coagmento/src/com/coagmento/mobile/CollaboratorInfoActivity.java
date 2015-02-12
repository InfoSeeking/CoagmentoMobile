package com.coagmento.mobile;

import java.io.IOException;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import com.coagmento.mobile.R;

import android.os.AsyncTask;
import android.os.Bundle;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.graphics.Bitmap;
import android.view.Menu;
import android.view.Window;
import android.widget.ImageView;
import android.widget.TextView;

public class CollaboratorInfoActivity extends Activity {
	
	Context context; 
	
	CollaboratorInfo info; 
	
	ProgressDialog progressBar; 
	
	ImageView avatar; 
	
	TextView username;
	
	TextView email;
	
	TextView organization;
	
	TextView website;
	
	Bitmap image; 
	
	String collaId; 
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		collaId=getIntent().getStringExtra("collaId");
		context=this;
		
		AsyncTask<Object, Object, Object> task = new AsyncTask<Object, Object, Object>() {
			
			@Override
			protected void onPreExecute(){
				progressBar = new ProgressDialog(context);
				progressBar.setTitle("Processing...");
				progressBar.setMessage("Please wait.");
				progressBar.setCancelable(true);
				progressBar.setIndeterminate(true);
				progressBar.show();
			}

			@Override
			protected Integer doInBackground(Object... params) {
				// TODO Auto-generated method stub
				try {
					info=XMLParser.getCollaInfo(collaId);
				} 
				catch (ParserConfigurationException e) {} 
				catch (SAXException e) {} 
				catch (IOException e) {}
				
				try {
					image=XMLParser.decode(info.getImage());
				} 
				catch (IOException e) {}
				
				return 1;
			}
			
			@Override
			protected void onPostExecute(Object i) {
				setContentView(R.layout.activity_collaborator_info);
				initializeLayout();
				assignValues();
				if (progressBar!=null) {
					progressBar.dismiss();	
				}
			}
		};
		task.execute();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.collaborator_info, menu);
		return true;
	}
	
	private void initializeLayout(){
		avatar=(ImageView)findViewById(R.id.avatar);
		username=(TextView)findViewById(R.id.username);
		email=(TextView)findViewById(R.id.email);
		organization=(TextView)findViewById(R.id.organization);
		website=(TextView)findViewById(R.id.website);
	}
	
	private void assignValues(){
		avatar.setImageBitmap(image);
		username.setText(info.getUsername());
		email.setText(info.getEmail());
		organization.setText(info.getOrganization());
		website.setText(info.getWebsite());
	}
}
