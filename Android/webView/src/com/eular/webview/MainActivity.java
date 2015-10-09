package com.eular.webview;

import android.os.Bundle;
import android.app.Activity;
import android.view.KeyEvent;
import android.view.Menu;
import android.webkit.WebView;

public class MainActivity extends Activity {
	private WebView webview;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        webview=new WebView(this);
        webview.getSettings().setJavaScriptEnabled(true);
        webview.loadUrl("file:///android_asset/birds.html");
        setContentView(webview);
    }
    
    public boolean onKeyDown(int keyCode,KeyEvent event){
    	if((keyCode==KeyEvent.KEYCODE_BACK)&&webview.canGoBack()){
    		webview.goBack();
    		return true;
    	}
    	return false;
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    
}
