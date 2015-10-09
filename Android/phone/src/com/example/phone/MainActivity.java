package com.example.phone;

import android.net.Uri;
import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends Activity {
	private EditText Etext;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Etext= (EditText) findViewById(R.id.editText1);
        Button Button1= (Button) this.findViewById(R.id.Button1);
        Button1.setOnClickListener(new ButtonClickListener());
    }
    
    private final class ButtonClickListener implements View.OnClickListener{
    	public void onClick(View v){
    		String number=Etext.getText().toString();
    		Intent intent=new Intent();
    		intent.setAction("android.intent.action.CALL");
    		intent.setData(Uri.parse("tel:"+number));
    		startActivity(intent);
    	}
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    
}
