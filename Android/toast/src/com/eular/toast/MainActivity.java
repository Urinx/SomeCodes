package com.eular.toast;

import android.os.Bundle;
import android.app.Activity;
import android.view.Gravity;
import android.view.Menu;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Toast;

public class MainActivity extends Activity {

    private Toast toast;


	@Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        photoToast();
        
        
        this.runOnUiThread(new Runnable() {               
            @Override 
            public void run() {
            	Toast.makeText(getApplicationContext(), "我来自其他线程！",Toast.LENGTH_LONG).show();
            }
        });

        positionToast(0,200);
	}

	private void photoToast() {
    	toast = Toast.makeText(getApplicationContext(), R.string.hello_world, Toast.LENGTH_SHORT);
		toast.setGravity(Gravity.CENTER, 0, 0);
		
		LinearLayout toastView = (LinearLayout) toast.getView();
		ImageView imageCodeProject = new ImageView(getApplicationContext());
		imageCodeProject.setImageResource(R.drawable.ic_launcher);
		toastView.addView(imageCodeProject, 0);
		
		toast.show();
	}


	private void positionToast(int x,int y) {
		toast = Toast.makeText(getApplicationContext(), R.string.hello_world, Toast.LENGTH_LONG);
		toast.setGravity(Gravity.CENTER, x, y);
		toast.show();
	}


	@Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    
}
