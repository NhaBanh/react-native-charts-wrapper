package com.github.wuxudong.rncharts.markers.custom;

import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.text.TextUtils;
import android.util.Log;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.appcompat.widget.LinearLayoutCompat;
import androidx.core.content.res.ResourcesCompat;

import com.github.mikephil.charting.charts.Chart;
import com.github.mikephil.charting.components.MarkerView;
import com.github.mikephil.charting.data.CandleEntry;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.highlight.Highlight;
import com.github.mikephil.charting.utils.MPPointF;
import com.github.mikephil.charting.utils.Utils;
import com.github.wuxudong.rncharts.R;

import java.util.List;
import java.util.Map;


public class RNBIOHMarkerView extends MarkerView {

    private TextView tvContent1, tvContent2, tvContent3, tvContent4;
    private TextView separate1, separate2;
    private LinearLayout ln;
    private ImageView hrImg, hrUpImg, hrDownImg;

    private  int color1, color2;
    private  int textSize1, textSize2;
    private Typeface tf1, tf2;

    private int digits = 0;

    public RNBIOHMarkerView(Context context) {
        super(context, R.layout.bioh_marker);

        tvContent1 = (TextView) findViewById(R.id.rectangle_tvContent1);
        tvContent2 = (TextView) findViewById(R.id.rectangle_tvContent2);
        tvContent3 = (TextView) findViewById(R.id.rectangle_tvContent3);
        tvContent4 = (TextView) findViewById(R.id.rectangle_tvContent4);

        separate1 = (TextView) findViewById(R.id.separate1);
        separate2 = (TextView) findViewById(R.id.separate2);

        ln = (LinearLayout) findViewById(R.id.linear_layout);

        hrImg = (ImageView) findViewById(R.id.hr);
        hrUpImg = (ImageView) findViewById(R.id.hrUp);
        hrDownImg = (ImageView) findViewById(R.id.hrDown);
    }

    public void setDigits(int digits) {
        this.digits = digits;
    }

    @Override
    public void refreshContent(Entry e, Highlight highlight) {
        String text1 = "";
        String text2 = "";
        String text3 = "";
        String text4 = "";

        if (e instanceof CandleEntry) {
            CandleEntry ce = (CandleEntry) e;
            text1 = Utils.formatNumber(ce.getClose(), digits, false);
        } else {
            text1 = Utils.formatNumber(e.getY(), digits, false);
        }

        if (e.getData() instanceof Map) {
            if (((Map) e.getData()).containsKey("marker")) {
                Object marker = ((Map) e.getData()).get("marker");
                String[] parts = marker.toString().split("@#@");

                switch (parts.length) {
                    case 1:
                        text1 = parts[0];
                        tvContent1.setTextColor(color1);
                        tvContent1.setTextSize(textSize1);
                        tvContent1.setTypeface(tf1);
                        break;
                    case 2:
                        text1 = parts[0];
                        text2 = parts[1];
                        tvContent1.setTextColor(color1);
                        tvContent1.setTextSize(textSize1);
                        tvContent1.setTypeface(tf1);
                        tvContent2.setTextColor(color2);
                        tvContent2.setTextSize(textSize2);
                        tvContent2.setTypeface(tf2);
                        break;
                    case 3:
                        text1 = parts[0];
                        text2 = parts[1];
                        text3 = parts[2];
                        tvContent1.setTextColor(color1);
                        tvContent1.setTextSize(textSize1);
                        tvContent1.setTypeface(tf1);
                        tvContent2.setTextColor(color1);
                        tvContent2.setTextSize(textSize1);
                        tvContent2.setTypeface(tf1);
                        tvContent3.setTextColor(color2);
                        tvContent3.setTextSize(textSize2);
                        tvContent3.setTypeface(tf2);
                        separate1.setVisibility(VISIBLE);
                        break;
                    case 4:
                        text1 = parts[0];
                        text2 = parts[1];
                        text3 = parts[2];
                        text4 = parts[3];
                        tvContent1.setTextColor(color1);
                        tvContent1.setTextSize(textSize1);
                        tvContent1.setTypeface(tf1);
                        tvContent2.setTextColor(color1);
                        tvContent2.setTextSize(textSize1);
                        tvContent2.setTypeface(tf1);
                        tvContent3.setTextColor(color1);
                        tvContent3.setTextSize(textSize1);
                        tvContent3.setTypeface(tf1);
                        tvContent4.setTextColor(color2);
                        tvContent4.setTextSize(textSize2);
                        tvContent4.setTypeface(tf2);
                        separate1.setVisibility(VISIBLE);
                        separate2.setVisibility(VISIBLE);
                        break;
                    default:
                }
                separate1.setTextColor(Color.parseColor("#D2D4D6"));
                separate1.setTextSize(textSize1);
                separate1.setTypeface(tf1);
                separate2.setTextColor(Color.parseColor("#D2D4D6"));
                separate2.setTextSize(textSize1);
                separate2.setTypeface(tf1);

                if (highlight.getStackIndex() != -1 && marker instanceof List) {
                    text1 = ((List) marker).get(highlight.getStackIndex()).toString();
                }

            }
        }

        if (TextUtils.isEmpty(text1)) {
            tvContent1.setVisibility(INVISIBLE);
            ln.setVisibility(INVISIBLE);
        } else {
            tvContent1.setText(text1);
            tvContent1.setVisibility(VISIBLE);
            ln.setVisibility(VISIBLE);
        }

        if (TextUtils.isEmpty(text2)) {
            tvContent2.setVisibility(INVISIBLE);
        } else {
            tvContent2.setText(text2);
            tvContent2.setVisibility(VISIBLE);
        }

        if (TextUtils.isEmpty(text3)) {
            tvContent3.setVisibility(INVISIBLE);
        } else {
            tvContent3.setText(text3);
            tvContent3.setVisibility(VISIBLE);
        }

        if (TextUtils.isEmpty(text4)) {
            tvContent4.setVisibility(INVISIBLE);
        } else {
            tvContent4.setText(text4);
            tvContent4.setVisibility(VISIBLE);
        }

        super.refreshContent(e, highlight);
    }

    @Override
    public MPPointF getOffset() {
        return new MPPointF(-(getWidth() / 2), -getHeight());
    }

    @Override
    public MPPointF getOffsetForDrawingAtPoint(float posX, float posY) {

        MPPointF offset = getOffset();

        MPPointF offset2 = new MPPointF();

        offset2.x = offset.x;
        offset2.y = offset.y;

        Chart chart = getChartView();

        float width = getWidth();

        if (posX + offset2.x < 0) {
            offset2.x = 0;
        } else if (chart != null && posX + width + offset2.x > chart.getWidth()) {
            offset2.x = -width;
        }

        offset2.y = -posY - 20f;
        return offset2;
    }

    public void setTextColor1(int color) {
        color1 = color;
    }

    public void setTextColor2(int color) {
        color2 = color;
    }

    public void setTextSize1(int size) {
        textSize1 = size;
    }

    public void setTextSize2(int size) {
        textSize2 = size;
    }

    public void setTextTypeface1(Typeface tf) {
        tf1 = tf;
    }

    public void setTextTypeface2(Typeface tf) {
        tf2 = tf;
    }

    public void setTextAlignment(int alignment) {
        tvContent1.setTextSize(alignment);
        tvContent2.setTextSize(alignment);
        tvContent3.setTextSize(alignment);
        tvContent4.setTextSize(alignment);
    }

    public void setHrImg(Drawable drawable) {
//        hrImg.setImageDrawable(drawable);
        hrImg.setVisibility(VISIBLE);
    }

    public void setHrImg(Bitmap bitmap) {
        hrImg.setImageBitmap(bitmap);
        hrImg.setVisibility(VISIBLE);
    }

    public void setHrUpImg(Drawable drawable) {
//        hrUpImg.setImageDrawable(drawable);
        hrUpImg.setVisibility(VISIBLE);
    }

    public void setHrDownImg(Drawable drawable) {
//        hrDownImg.setImageDrawable(drawable);
        hrDownImg.setVisibility(VISIBLE);
    }

    public void setBackgroundTintList(ColorStateList list) {
        ln.setBackgroundTintList(list);
    }
}

