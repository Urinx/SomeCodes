package com.eular.uriandeular;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

public class Info extends Activity{
	protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.info);
        
        this.findViewById(R.id.back_button).setOnClickListener(new View.OnClickListener() {
			public void onClick(View v) {
				Info.this.finish();
			}
		});
	}
}
