package com.coagmento.mobile;

import com.coagmento.mobile.R;

import android.graphics.Color;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentTabHost;
import android.view.Window;

public class FragmentTabsActivity extends FragmentActivity {

    FragmentTabHost mTabHost;
    
    static String userID;
    static String projectID;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        userID=getIntent().getStringExtra("userID");
        projectID=getIntent().getStringExtra("projectID");
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_fragment_tabs);
        Bundle bundle=new Bundle();
        bundle.putString("userID", userID);
        bundle.putString("projectID", projectID);
        
        mTabHost = (FragmentTabHost)findViewById(android.R.id.tabhost);
        mTabHost.setup(this, getSupportFragmentManager(), R.id.tabFrameLayout);
        
        mTabHost.addTab(mTabHost.newTabSpec("tab1").setIndicator("CSpace",getResources().getDrawable(R.drawable.tab_icon_cspace)),
                CSpaceFragment.class, bundle);
        
        mTabHost.addTab(mTabHost.newTabSpec("tab2").setIndicator("Webpages",getResources().getDrawable(R.drawable.tab_icon_webpage)),
                WebPagesFragment.class, bundle);
     
        mTabHost.addTab(mTabHost.newTabSpec("tab3").setIndicator("Searches",getResources().getDrawable(R.drawable.tab_icon_searches)),
                SearchesFragment.class, bundle);
        
        mTabHost.addTab(mTabHost.newTabSpec("tab4").setIndicator("Collection",getResources().getDrawable(R.drawable.tab_icon_collections)),
                CollectionFragment.class, bundle);
        
        mTabHost.addTab(mTabHost.newTabSpec("tab5").setIndicator("Members",getResources().getDrawable(R.drawable.tab_icon_members)),
                MembersFragment.class, bundle);   
        
        for (int i = 0; i < mTabHost.getTabWidget().getTabCount(); i++) {
		    mTabHost.getTabWidget().getChildAt(i).setBackgroundColor(Color.parseColor("#86E4EF"));
		}     
    }
}

