package com.eular.uriandeular;

import com.eular.uriandeular.util.SystemUiHider;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Toast;

/**
 * An example full-screen activity that shows and hides the system UI (i.e.
 * status bar and navigation/system bar) with user interaction.
 *
 * @see SystemUiHider
 */
public class FullscreenActivity extends Activity {
	private Toast toast;
	
    /**
     * Whether or not the system UI should be auto-hidden after
     * {@link #AUTO_HIDE_DELAY_MILLIS} milliseconds.
     */
    private static final boolean AUTO_HIDE = true;

    /**
     * If {@link #AUTO_HIDE} is set, the number of milliseconds to wait after
     * user interaction before hiding the system UI.
     */
    private static final int AUTO_HIDE_DELAY_MILLIS = 3000;

    /**
     * If set, will toggle the system UI visibility upon interaction. Otherwise,
     * will show the system UI visibility upon interaction.
     */
    private static final boolean TOGGLE_ON_CLICK = true;

    /**
     * The flags to pass to {@link SystemUiHider#getInstance}.
     */
    private static final int HIDER_FLAGS = SystemUiHider.FLAG_HIDE_NAVIGATION;

    /**
     * The instance of the {@link SystemUiHider} for this activity.
     */
    private SystemUiHider mSystemUiHider;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_fullscreen);

        final View controlsView = findViewById(R.id.fullscreen_content_controls);
        final View contentView = findViewById(R.id.fullscreen_content);

        // Set up an instance of SystemUiHider to control the system UI for
        // this activity.
        mSystemUiHider = SystemUiHider.getInstance(this, contentView, HIDER_FLAGS);
        mSystemUiHider.setup();
        mSystemUiHider
                .setOnVisibilityChangeListener(new SystemUiHider.OnVisibilityChangeListener() {
                    // Cached values.
                    int mControlsHeight;
                    int mShortAnimTime;

                    @Override
                    @TargetApi(Build.VERSION_CODES.HONEYCOMB_MR2)
                    public void onVisibilityChange(boolean visible) {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB_MR2) {
                            // If the ViewPropertyAnimator API is available
                            // (Honeycomb MR2 and later), use it to animate the
                            // in-layout UI controls at the bottom of the
                            // screen.
                            if (mControlsHeight == 0) {
                                mControlsHeight = controlsView.getHeight();
                            }
                            if (mShortAnimTime == 0) {
                                mShortAnimTime = getResources().getInteger(
                                        android.R.integer.config_shortAnimTime);
                            }
                            controlsView.animate()
                                    .translationY(visible ? 0 : mControlsHeight)
                                    .setDuration(mShortAnimTime);
                        } else {
                            // If the ViewPropertyAnimator APIs aren't
                            // available, simply show or hide the in-layout UI
                            // controls.
                            controlsView.setVisibility(visible ? View.VISIBLE : View.GONE);
                        }

                        if (visible && AUTO_HIDE) {
                            // Schedule a hide().
                            delayedHide(AUTO_HIDE_DELAY_MILLIS);
                        }
                    }
                });

        // Set up the user interaction to manually show or hide the system UI.
        contentView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (TOGGLE_ON_CLICK) {
                    mSystemUiHider.toggle();
                } else {
                    mSystemUiHider.show();
                }
            }
        });

        
        findViewById(R.id.dummy_button).setOnTouchListener(new OnTouchListener(){

			@Override
			public boolean onTouch(View v, MotionEvent m) {
				// TODO Auto-generated method stub
				startActivity(new Intent(getApplicationContext(),Info.class));
				return false;
			}});
    }

    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
        delayedHide(100);
        
        //start toast
        startChat();
    }


    private void startChat() {
    	duihua("啊哈哈","嘟嘟噜");
    	duihua("爆个照！","一起来。");
    	photoToast("怎么样，，", R.drawable.head1,60,-120);
    	photoToast("我勒个去。。", R.drawable.head2,-60,160);
    	
    	duihua("你原先有过女朋友?","十年生死两茫茫，不思量，自难忘。");
    	duihua("死了?怎么死的?","山天陵，江水为竭，冬雷阵阵夏雨雪。");
    	duihua("喔，是天灾。那这些年你怎么过来的?","满面尘灰烟火色，两手苍苍十指黑。");
    	duihua("唉，不容易。那么你看见我的第一感觉是什么?","忽如一夜春风来，千树万树梨花开。");
    	duihua("(红着脸)有那么好?","糟粕所传非粹美，丹青难写是精神。");
    	duihua("马屁精--你有理想吗?","他年若遂凌云志，敢笑黄巢不丈夫。");
    	duihua("你……对爱情的看法呢?","只在此山中，云深不知处。");
    	duihua("那你喜欢读书吗?","军书十二卷，卷卷有爷名!");
    	duihua("这牛吹大了吧?你那么大才华，怎么还独身?","小姑未嫁身如寄，莲子心多苦自知。");
    	duihua("(笑)假如，我是说假如，我答应嫁给你，你打算怎样待我?","一片冰心在玉壶!");
    	duihua("你保证不会对别的男人动心?","波澜誓不起，妾心古井水。");
    	duihua("暂且信你一回，不过，我正打算去华科念书，你能等我吗?","此去经年，应是良辰美景虚设。");
    	duihua("不过……","独自凭栏，无限江山，别时容易见时难!");
    	duihua("但是……","望夫处，江悠悠，化为石，不回头!");
    	positionToast("好了好了，怕了你………",60,-110);
    	photoToast("吓。。", R.drawable.xia,-60,160);
    	
    	positionToast("在一起后",0,0);
    	duihua("结婚那么久，你还在想你原先的女朋友?","曾经沧海难为水，除却巫山不是云。");
    	duihua("那为什么当年还和我结婚?","梦里不知身是客，一晌贪欢。");
    	duihua("太过分了吧。我们好歹是夫妻。","夫妻本是同林鸟，大难临头各自飞。");
    	duihua("那我们这段婚姻，你怎么看?","醒来几向楚巾看，梦觉尚心寒!");
    	duihua("有那么惨吗?你不是说对我的第一印象……","美女如花满春殿，身边惟有鹧鸪飞。");
    	duihua("不是这么说的吧，难道，你竟然……","昔日龌龊不足夸，今朝放荡思无涯。");
    	duihua("一直以来朋友写信告诉我我都不相信，没想到竟是真的!","纸上得来终觉浅，绝知此事要躬行。");
    	duihua("你原先的理想都到哪儿去了?","且把浮名，换了斟低唱。");
    	duihua("(泪眼朦胧)你，你不是答应一片冰心的吗?","不忍见此物，焚之已成灰。");
    	duihua("你就不怕亲朋耻笑，后世唾骂?","宁可抱香枝头死，何曾吹落北风中。");
    	duihua("我要不同意分手呢?","分手尚且为兄弟，何必非做骨肉亲。");
    	duihua("好，够绝。","呃呃。。");
    	positionToast("End",0,0);
	}


	private void duihua(String w1,String w2) {
		positionToast(w1,60,-110);
        positionToast(w2,-60,140);
	}


	Handler mHideHandler = new Handler();
    Runnable mHideRunnable = new Runnable() {
        @Override
        public void run() {
            mSystemUiHider.hide();
        }
    };

    private void delayedHide(int delayMillis) {
        mHideHandler.removeCallbacks(mHideRunnable);
        mHideHandler.postDelayed(mHideRunnable, delayMillis);
    }
    
    //--------------------------
    //toast method
    private void photoToast(String words, int Rid,int x,int y) {
    	toast = Toast.makeText(getApplicationContext(), words, Toast.LENGTH_SHORT);
		toast.setGravity(Gravity.CENTER, x, y);
		
		LinearLayout toastView = (LinearLayout) toast.getView();
		ImageView imageCodeProject = new ImageView(getApplicationContext());
		imageCodeProject.setImageResource(Rid);
		toastView.addView(imageCodeProject, 0);
		
		toast.show();
	}

	private void positionToast(String words,int x,int y) {
		toast = Toast.makeText(getApplicationContext(), words, Toast.LENGTH_SHORT);
		toast.setGravity(Gravity.CENTER, x, y);
		toast.show();
	}
	//--------------------------
}
