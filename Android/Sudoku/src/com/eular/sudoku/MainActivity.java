package com.eular.sudoku;

import android.os.Bundle;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;

public class MainActivity extends Activity implements OnClickListener{

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        View continueButton=this.findViewById(R.id.continue_button);
        continueButton.setOnClickListener(this);
        View newButton=this.findViewById(R.id.new_button);
        newButton.setOnClickListener(this);
        View aboutButton=this.findViewById(R.id.about_button);
        aboutButton.setOnClickListener(this);
        View exitButton=this.findViewById(R.id.exit_button);
        exitButton.setOnClickListener(this);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    
    public boolean onOptionsItemSelected(MenuItem item){
    	switch(item.getItemId()){
    	case R.id.settings:
    		startActivity(new Intent(this,Settings.class));
    		return true;
    	}
    	return false;
    }


	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		switch (v.getId()){
		case R.id.about_button:
			Intent i=new Intent(this,About.class);
			startActivity(i);
			break;
		case R.id.new_button:
			openNewGameDialog();
			break;
		}
	}

	private static final String TAG="Sudoku";
	private void openNewGameDialog() {
		new AlertDialog.Builder(this)
		.setTitle(R.string.new_game_title)
		.setItems(R.array.difficulty,new DialogInterface.OnClickListener() {
			@Override
			public void onClick(DialogInterface dialog, int i) {
				startGame(i);
			}
		}).show();
	}


	protected void startGame(int i) {
		Log.d(TAG,"clicked on "+i);
	}
    
}
