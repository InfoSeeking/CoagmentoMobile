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

public class SnippetItemAdapter extends BaseAdapter{
	
	Activity activity;
	
	LayoutInflater inflater;

	List<WebPage> items;
	
	public SnippetItemAdapter(Activity a, List<WebPage> list){
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
            vi = inflater.inflate(R.layout.list_item_snippet, null);
        }
        TextView title=(TextView)vi.findViewById(R.id.webtitle);
        TextView note=(TextView)vi.findViewById(R.id.note);
        Snippet curr=(Snippet)items.get(position);
        title.setText(curr.getTitle());
        note.setText(curr.getNode());
		return vi;
	}
}
