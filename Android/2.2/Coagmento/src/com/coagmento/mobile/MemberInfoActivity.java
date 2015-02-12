package com.coagmento.mobile;

import java.io.IOException;

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

public class MemberInfoActivity extends Activity {
    
	private String name;
	private String avatar;
	private String email;
	private String organization;
	private Bitmap thumnail;
	
	ImageView image;
	TextView nameView;
	TextView emailView;
	TextView organizationView;
	
	Context context;
	ProgressDialog progressBar;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		context=this;
		name=getIntent().getStringExtra("name");
		avatar=getIntent().getStringExtra("avatar");
		email=getIntent().getStringExtra("email");
		organization=getIntent().getStringExtra("organization");
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
			protected Object doInBackground(Object... params) {
				// TODO Auto-generated method stub
				try {
					thumnail=XMLParser.decode(avatar);
				} catch (IOException e) {}
				return null;
			}
			@Override
			protected void onPostExecute(Object i){
				try {
					initializeLayout();
				} 
				catch (IOException e) {}
				progressBar.dismiss();
			}
		};
		task.execute();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.member_info, menu);
		return true;
	}
	
	private void initializeLayout() throws IOException{
		setContentView(R.layout.activity_member_info);
		image=(ImageView)findViewById(R.id.mavatar);
		nameView=(TextView)findViewById(R.id.musername);
		emailView=(TextView)findViewById(R.id.memail);
		organizationView=(TextView)findViewById(R.id.morganization);
		image.setImageBitmap(thumnail);
		nameView.setText(this.name);
		emailView.setText(this.email);
		organizationView.setText(this.organization);
	}

}
