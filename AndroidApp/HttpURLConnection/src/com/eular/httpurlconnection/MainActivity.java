package com.eular.httpurlconnection;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import android.os.AsyncTask;
import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import android.widget.Toast;

public class MainActivity extends Activity {

    private String resultData="";


	@Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        /*try {
        	HttpURLConnection_GET("http://xiaouri.sinaapp.com");
        } catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}*/
        
        try {
			HttpURLConnection_POST("http://xiaouri.sinaapp.com","word","ет");
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        Toast.makeText(getApplicationContext(), resultData, Toast.LENGTH_LONG).show();
        
    }

    private void HttpURLConnection_POST(String url,String params,String values) throws MalformedURLException, IOException {
    	HttpURLConnection urlConn=(HttpURLConnection) new URL(url).openConnection();
    	urlConn.setDoOutput(true);
		urlConn.setDoInput(true);
    	urlConn.setRequestMethod("POST");
		urlConn.setUseCaches(false);
		urlConn.setInstanceFollowRedirects(true);
		urlConn.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
		urlConn.connect();
		
		DataOutputStream out=new DataOutputStream(urlConn.getOutputStream());
		String content=params+"="+URLEncoder.encode(values);
		out.writeBytes(content);
		out.flush();
		out.close();
		
		InputStreamReader in=new InputStreamReader(urlConn.getInputStream());
		BufferedReader buffer=new BufferedReader(in);
		String inputLine=null;
		while(((inputLine=buffer.readLine())!=null)){
			resultData+=inputLine+"\n";
		}
		in.close();
		
		urlConn.disconnect();
	}


	private void HttpURLConnection_GET(String url) throws MalformedURLException, IOException {
		HttpURLConnection urlConn=(HttpURLConnection) new URL(url).openConnection();
		
		InputStreamReader in=new InputStreamReader(urlConn.getInputStream());
		BufferedReader buffer=new BufferedReader(in);
		String inputLine=null;
		while(((inputLine=buffer.readLine())!=null)){
			resultData+=inputLine+"\n";
		}
		in.close();
		urlConn.disconnect();
	}


	@Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    
}
