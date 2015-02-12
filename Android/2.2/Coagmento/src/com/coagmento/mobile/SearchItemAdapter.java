package com.coagmento.mobile;

import java.util.List;

import com.coagmento.mobile.R;


import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

public class SearchItemAdapter extends BaseAdapter{
	
	Activity activity;
	
	LayoutInflater inflater;

	List<SearchItem> items;
	
	public SearchItemAdapter(Activity a, List<SearchItem> list){
		this.activity=a;
		this.inflater=(LayoutInflater)activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		this.items=list;
	}
	
	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		return items.size();
	}

	@Override
	public Object getItem(int position) {
		// TODO Auto-generated method stub
		return items.get(position);
	}

	@Override
	public long getItemId(int position) {
		// TODO Auto-generated method stub
		return position;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		// TODO Auto-generated method stub
		View vi=convertView;
        if(convertView==null){
            vi = inflater.inflate(R.layout.list_item_searches, null);
        }
        TextView query=(TextView)vi.findViewById(R.id.searchquery);
        TextView source=(TextView)vi.findViewById(R.id.searchsource);
        SearchItem curr=items.get(position);
        query.setText(curr.getQuery());
        source.setText(curr.getSource());
		return vi;
	}

}
