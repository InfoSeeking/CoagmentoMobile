package com.coagmento.mobile;

import java.util.List;
import com.coagmento.mobile.R;
import android.app.Activity;
import android.content.Context;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class CSpaceItemAdapter extends BaseAdapter{
	
	Activity activity;
	
	LayoutInflater inflater;
	
	List<CSpaceItem> items;
	
	public CSpaceItemAdapter(Activity a,List<CSpaceItem> items){
		this.activity=a;
		this.items=items;
		this.inflater=(LayoutInflater)activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
	}
	
	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		return this.items.size();
	}
	
	@Override
	public Object getItem(int position) {
		// TODO Auto-generated method stub
		return this.items.get(position);
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
            vi = inflater.inflate(R.layout.list_item_cspace, null);
        }
        ImageView thumbnail=(ImageView)vi.findViewById(R.id.snapshot);
        TextView title=(TextView)vi.findViewById(R.id.title);
        TextView url=(TextView)vi.findViewById(R.id.url);
        CSpaceItem curr=items.get(position);
		thumbnail.setImageBitmap(curr.getImage());
        title.setGravity(Gravity.TOP);
        title.setText(curr.getTitle());
        url.setText(curr.getURL());
		return vi;
	}
   
}
