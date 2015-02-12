package com.coagmento.mobile;

import com.coagmento.mobile.R;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTabHost;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

public class CollectionFragment extends Fragment{
    
	FragmentTabHost mTabHost;
	
	private String projectID;
	
	@Override
	public void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		Bundle bundle=getArguments(); 
		projectID=bundle.getString("projectID");
	} 
	
	@Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
		Bundle bundle=new Bundle();
		bundle.putString("projectID", projectID);
		mTabHost = new FragmentTabHost(getActivity());
		mTabHost.setup(getActivity(), getChildFragmentManager(), R.layout.activity_fragment_tabs);
		mTabHost.addTab(mTabHost.newTabSpec("tab1").setIndicator("Snippets"),
	                SnippetFragment.class, bundle);
		mTabHost.addTab(mTabHost.newTabSpec("tab2").setIndicator("Annotations"),
                AnnotationFragment.class, bundle);
		for (int i = 0; i < mTabHost.getTabWidget().getTabCount(); i++) {
		    mTabHost.getTabWidget().getChildAt(i).getLayoutParams().height = 85;
		    mTabHost.getTabWidget().getChildAt(i).setBackgroundResource(R.drawable.bluebg);
		}  
		return mTabHost;
    }
	
}
