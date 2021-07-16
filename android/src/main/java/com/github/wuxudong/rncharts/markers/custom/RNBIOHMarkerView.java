package com.github.wuxudong.rncharts.markers.custom;

import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.text.TextUtils;
import android.util.Log;
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

    private TextView tvContent1;
    private TextView tvContent2;
    private LinearLayout ln;

    private Drawable backgroundLeft = ResourcesCompat.getDrawable(getResources(), R.drawable.biohmarker, null);
    private Drawable background = ResourcesCompat.getDrawable(getResources(), R.drawable.biohmarker, null);
    private Drawable backgroundRight = ResourcesCompat.getDrawable(getResources(), R.drawable.biohmarker, null);

    private Drawable backgroundTopLeft = ResourcesCompat.getDrawable(getResources(), R.drawable.biohmarker, null);
    private Drawable backgroundTop = ResourcesCompat.getDrawable(getResources(), R.drawable.biohmarker, null);
    private Drawable backgroundTopRight = ResourcesCompat.getDrawable(getResources(), R.drawable.biohmarker, null);

    private int digits = 0;

    public RNBIOHMarkerView(Context context, float chartHeight) {
        super(context, R.layout.bioh_marker);

        tvContent1 = (TextView) findViewById(R.id.rectangle_tvContent1);
        tvContent2 = (TextView) findViewById(R.id.rectangle_tvContent2);
        ln = (LinearLayout) findViewById(R.id.linear_layout);
    }

    public void setDigits(int digits) {
        this.digits = digits;
    }

    @Override
    public void refreshContent(Entry e, Highlight highlight) {
        String text1 = "";
        String text2 = "";

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
                if(parts.length >= 1){
                    text1 = parts[0];
                }
                if(parts.length >= 2){
                    text2 = parts[1];
                }

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
            tvContent2.setText(" " + text2);
            tvContent2.setVisibility(VISIBLE);
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

            if (posY + offset2.y < 0) {
                offset2.y = 0;
                ln.setBackground(backgroundTopLeft);
            } else {
                ln.setBackground(backgroundLeft);
            }

        } else if (chart != null && posX + width + offset2.x > chart.getWidth()) {
            offset2.x = -width;

            if (posY + offset2.y < 0) {
                offset2.y = 0;
                ln.setBackground(backgroundTopRight);
            } else {
                ln.setBackground(backgroundRight);
            }
        } else {
            if (posY + offset2.y < 0) {
                offset2.y = 0;
                ln.setBackground(backgroundTop);
            } else {
                ln.setBackground(background);
            }
        }
        offset2.y = -posY - 20f;
        return offset2;
    }

    public void setTextColor1(int color) {
        tvContent1.setTextColor(color);
    }

    public void setTextColor2(int color) {
        tvContent2.setTextColor(color);
    }

    public void setTextSize1(int size) {
        tvContent1.setTextSize(size);
    }

    public void setTextSize2(int size) {
        tvContent2.setTextSize(size);
    }

    public void setTextTypeface1(Typeface tf) {
        tvContent1.setTypeface(tf);
    }

    public void setTextTypeface2(Typeface tf) {
        tvContent2.setTypeface(tf);
    }

    public void setTextAlignment(int alignment) {
        tvContent1.setTextSize(alignment);
        tvContent2.setTextSize(alignment);
    }

    public void setBackgroundTintList(ColorStateList list) {
        ln.setBackgroundTintList(list);
    }
}

