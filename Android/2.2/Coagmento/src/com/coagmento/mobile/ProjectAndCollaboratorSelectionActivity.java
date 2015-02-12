package com.coagmento.mobile;

import com.coagmento.mobile.R;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentTabHost;
import android.view.Window;

public class ProjectAndCollaboratorSelectionActivity extends FragmentActivity {
	
    FragmentTabHost mTabHost;
    
    static String userId;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
    	super.onCreate(savedInstanceState);
    	requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_project_and_collaborator_selection);
        userId=getIntent().getStringExtra("id");
        Bundle bundle=new Bundle();
        bundle.putString("id", userId);
        
        mTabHost = (FragmentTabHost) findViewById(android.R.id.tabhost);
        
        mTabHost.setup(this, getSupportFragmentManager(), R.id.tabFrameLayout);

        mTabHost.addTab(
                mTabHost.newTabSpec("tab1").setIndicator("Project",
                        getResources().getDrawable(android.R.drawable.star_on)),
                ProjectFragment.class, bundle);
        mTabHost.addTab(
                mTabHost.newTabSpec("tab2").setIndicator("Collaborator",
                        getResources().getDrawable(android.R.drawable.star_on)),
                CollaboratorFragment.class, bundle);
    }
}

