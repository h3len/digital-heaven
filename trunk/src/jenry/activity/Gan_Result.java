package jenry.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class Gan_Result extends Activity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.result);
        
        Intent intent = getIntent();
        String one = intent.getStringExtra("one");
        String two = intent.getStringExtra("two");
        TextView myResult=(TextView)findViewById(R.id.myResult);
        myResult.setText(Integer.parseInt(one)*Integer.parseInt(two)+"");
    }
}