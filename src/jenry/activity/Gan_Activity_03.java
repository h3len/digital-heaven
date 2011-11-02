package jenry.activity;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class Gan_Activity_03 extends Activity {

	private EditText myOne ;
	private EditText myTwo;
	private TextView symbol;
	private Button myButton;
	private Button mySendSMS;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        myOne=(EditText)findViewById(R.id.myOne);
        myTwo=(EditText)findViewById(R.id.myTwo);
        symbol=(TextView)findViewById(R.id.symbol);
        myButton=(Button)findViewById(R.id.myButton);
        
        symbol.setText(R.string.symbol);
        myButton.setText(R.string.myButtonText);
        myButton.setOnClickListener(new MyButtonListent());
        
        mySendSMS=(Button)findViewById(R.id.mySendSMS);
        mySendSMS.setText(R.string.sendSMS);
        mySendSMS.setOnClickListener(new MySendSMSListent());
    }
    
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		//menu.add(0,1,1,R.string.exit);
		//menu.add(0,2,2,R.string.help);
		//return super.onCreateOptionsMenu(menu);
		
		// 获取当前的菜单
		MenuInflater inflater = getMenuInflater();
		// 填充菜单
		inflater.inflate(R.menu.option_menu, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		if(item.getItemId() == 1){
			finish();
		}
		return super.onOptionsItemSelected(item);
	}
    
    class MyButtonListent implements OnClickListener{
    	
    	public void onClick(View v) {
			String myOneStr = myOne.getText().toString();
			String myTwoStr = myTwo.getText().toString();
			
			Intent intent = new Intent();
			intent.putExtra("one",myOneStr);
			intent.putExtra("two",myTwoStr);
			intent.setClass(Gan_Activity_03.this,Gan_Result.class);
			
			Gan_Activity_03.this.startActivity(intent);
		}
    	
    }
    
    class MySendSMSListent implements OnClickListener{
    	
    	public void onClick(View v) {
			Uri uri = Uri.parse("smsto:08600002222");
			Intent intent = new Intent(Intent.ACTION_SENDTO,uri);
			intent.putExtra("sms_body", "The SMS Text.");
			Gan_Activity_03.this.startActivity(intent);
		}
    	
    }
}