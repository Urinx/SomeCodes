package com.eular.fileio;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity {
	private EditText filename;
	private EditText filecontent;
	private TextView fileread;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        filename=(EditText) this.findViewById(R.id.filename);
        filecontent=(EditText) this.findViewById(R.id.filecontent);
        fileread=(TextView) this.findViewById(R.id.readview);
        
        Button saveButton=(Button)this.findViewById(R.id.savebutton);
        saveButton.setOnClickListener(new ButtonClickListener());
        
        Button readButton=(Button)this.findViewById(R.id.readbutton);
        readButton.setOnClickListener(new View.OnClickListener(){
        	public void onClick(View v) {
        		String fn=filename.getText().toString();
        		FileService service=new FileService(getApplicationContext());
        		try {
					String data=service.read(fn);
					Toast.makeText(getApplicationContext(), R.string.readsuccess, 1).show();
					fileread.setText(data);
				} catch (Exception e) {
					Toast.makeText(getApplicationContext(), R.string.readfail, 1).show();
					e.printStackTrace();
				}
        	}
        });
    }
    
    private final class ButtonClickListener implements View.OnClickListener{

		@Override
		public void onClick(View v) {
			String fn=filename.getText().toString();
			String fc=filecontent.getText().toString();
			FileService service=new FileService(getApplicationContext());
			try{
				service.save(fn,fc);
				Toast.makeText(getApplicationContext(), R.string.success, 1).show();
				filecontent.setText("");
			}catch(Exception e){
				Toast.makeText(getApplicationContext(), R.string.fail, 1).show();
				e.printStackTrace();
			}
		}
    	
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    
}
