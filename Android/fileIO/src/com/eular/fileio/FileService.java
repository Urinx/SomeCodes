package com.eular.fileio;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import android.content.Context;
import android.widget.Toast;

public class FileService {
	private Context context;
	
	public FileService(Context context){
		this.context=context;
	}

	public void save(String fn, String fc) {
		try {
			FileOutputStream outStream=context.openFileOutput(fn, Context.MODE_PRIVATE);
			outStream.write(fc.getBytes());
			outStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String read(String fn) throws Exception{
		FileInputStream inStream=context.openFileInput(fn);
		ByteArrayOutputStream outStream=new ByteArrayOutputStream();
		byte[] buffer=new byte[1024];
		int len=0;
		while((len=inStream.read(buffer))!=-1){
			outStream.write(buffer, 0, len);
		}
		byte[] data=outStream.toByteArray();
		return new String(data);
	}

}
