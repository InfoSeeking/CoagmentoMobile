package com.coagmento.mobile;

import java.io.IOException;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import com.coagmento.mobile.R;

import android.os.AsyncTask;
import android.os.Bundle;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;

public class LoginActivity extends Activity implements OnClickListener{
	
	private Button signIn;
	private Button signUp;
	private EditText username;
	private EditText password;
	
	private String userName,passWord;
	private String userID;
	
	LoginActivity current;
	ProgressDialog progressBar;
	
	Context context;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_login);
		initializeLayout();
		current=this;
		context=this;
	}
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.login, menu);
		return true;
	}
	
	private void initializeLayout() {
		signIn=(Button)findViewById(R.id.signin);
		signUp=(Button)findViewById(R.id.signup);
		username=(EditText)findViewById(R.id.username);
		setTextFieldProperties(username);
		password=(EditText)findViewById(R.id.password);
		setTextFieldProperties(password);
		signIn.setOnClickListener(this);
		signUp.setOnClickListener(this);
		signUp.setBackgroundColor(Color.TRANSPARENT);
	}
	
	private void setTextFieldProperties(EditText textField){
		textField.setMaxWidth(textField.getWidth());
		textField.setMaxHeight(textField.getHeight());
	}
	
	public void onClick(View v) {
		switch(v.getId()){
		
			case R.id.signin:
				userName=username.getText().toString().trim();
				passWord=password.getText().toString().trim();
				
				AsyncTask<Void, Void, Integer> task = new AsyncTask<Void, Void, Integer>() {
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
						protected Integer doInBackground(Void... params) {
							// TODO Auto-generated method stub
							int connectionStatus=-1;
							try {
								connectionStatus=XMLParser.Connect(current, userName, passWord);
							} 
							catch (IOException e) {} 
							catch (ParserConfigurationException e) {} 
							catch (SAXException e) {}
							
							return connectionStatus;
						}
						@Override
					    protected void onPostExecute(Integer connectionStatus) {
							
						   progressBar.dismiss();
						   
					       if(connectionStatus==1){
					    	   Intent intent=new Intent(current,ProjectAndCollaboratorSelectionActivity.class);
					    	   intent.putExtra("id",current.getUserId());
							   current.startActivity(intent);
					       }
					       else{
								String message="The username or password is incorrect!";
								showDialog(message,false);
							}
					    }
				};
				task.execute();
				break;
				
			case R.id.signup:
				Intent intent=new Intent(this, SignUpActivity.class);
				startActivity(intent);
				break;
				
			default:break;
		}
	}
	
	public void showDialog(String message,boolean cancelable){
		AlertDialog.Builder builder = new AlertDialog.Builder(current);
		builder.setMessage(message)
	       .setCancelable(cancelable)
	       .setPositiveButton("OK", new DialogInterface.OnClickListener() {
	           public void onClick(DialogInterface dialog, int id) {
	                //nothing happens
	           }
	       });
		AlertDialog alert = builder.create();
		alert.show();
	}
	
	public String getUserId(){
		return this.userID;
	}
	
	public void setUserId(String id){
		this.userID=id;
	}
}
