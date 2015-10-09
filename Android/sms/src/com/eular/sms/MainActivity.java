package com.eular.sms;

import java.util.ArrayList;

import android.os.Bundle;
import android.app.Activity;
import android.telephony.gsm.SmsManager;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

@SuppressWarnings("deprecation")
public class MainActivity extends Activity {
	private EditText numberlabel;
	private EditText smscontent;
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        numberlabel=(EditText) this.findViewById(R.id.numberlabel);
        smscontent=(EditText) this.findViewById(R.id.smscontent);
        
        Button send=(Button) this.findViewById(R.id.send);
        send.setOnClickListener(new ButtonClickListener());
    }
    
    private final class ButtonClickListener implements View.OnClickListener{
    	public void onClick(View v){
    		String phone=numberlabel.getText().toString();
            String sms=smscontent.getText().toString();
            SmsManager manager=SmsManager.getDefault();
            ArrayList<String> texts=manager.divideMessage(sms);
            for(String text:texts){
            	manager.sendTextMessage(phone, null, text, null, null);
            }
            Toast.makeText(getApplicationContext(), R.string.success, 1).show();
            smscontent.setText("");
    	}
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    
}
