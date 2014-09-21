package com.eular.uribad;

import java.io.FileOutputStream;
import java.io.IOException;

import android.content.Context;

public class FileService {
	private Context context;
	
	public FileService(Context context){
		this.context=context;
	}

	public void writeFileInAndroid(String fn,String fc) throws IOException {
		FileOutputStream outStream=context.openFileOutput(fn, Context.MODE_PRIVATE);
		outStream.write(fc.getBytes());
		outStream.close();
	}

}
