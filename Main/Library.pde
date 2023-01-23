public static class Easing {
    // retは戻り値用変数 
    static float easeIn() {
        float ret = 0;
        
        return ret;
    }
    
    static float easeOut() {
        float ret = 0;
        
        return ret;
    }
}

//--------------------------------------------------------------------------------------
// 以下ボタンライブラリ

import java.lang.reflect.Method;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

PApplet papplet = this;

public class Button {
    // ボタンの設定のインスタンス生成
    Set set;
    // mainクラスのメソッド
    Object obj = null;
    // ボタンをクリックされたときにclickButtonEventの引数に渡される文字列
    String buttonName;
    // ボタンクリックとマウスクリックに関するフラグ
    boolean clickFlag = false;
    boolean clickOldOnFlag = false;
    boolean clickOnFlag = false;
    // 表示フラグ
    boolean visible = true;
    
    // ボタンの設定クラス
    class Set {
        // x座標, y座標, 幅, 高さ, 角丸の半径
        float x;
        float y;
        float width;
        float height;
        float radius;
        // ラベルの位置 X, Y, ラベルの文字サイズ
        float labelX;
        float labelY;
        float labelSize = 1;
        // Align horizontal:x軸, vertical:y軸
        int horizontal;
        int vertical;
        // ラベルの文字
        String textlabel = "";
        // ボタンの中の色, ボタンの外枠の色, ラベルの色
        color rectColor;
        color rectEdgeColor;
        color rectHoverColor;
        color textColor;
        PFont font;
        PImage img = null;
        
        // ボタンの設定のコンストラクタ
        Set() {
            // テキストの初期Alignは（CENTER, CENTER）
            this.align(CENTER, CENTER);
        }
        
        void position(float _x, float _y) {
            this.x = _x;
            this.y = _y;
            this.labelPos();
        }
        
        void bgImage(PImage _img) {
            img = _img;
        }
        
        void size(float _w, float _h, float _r) {
            this.width = _w;
            this.height = _h;
            this.radius = _r;
        }
        
        void buttonColor(color _rectColor, color _rectEdgeColor) {
            this.rectColor = _rectColor;
            this.rectEdgeColor = _rectEdgeColor;
        }
        
        void buttonHoverColor(color _rectHoverColor) {
            this.rectHoverColor = _rectHoverColor;
        }
        
        void label(String _text, float _labelSize) {
            this.textlabel = _text;
            this.labelSize(_labelSize);
            this.labelPos();
        }
        
        void label(String _text, float _labelSize, PFont _font) {
            this.textlabel = _text;
            this.labelSize(_labelSize);
            this.labelFont(_font);
            this.labelPos();
        }
        
        void labelSize(float _labelSize) {
            this.labelSize = _labelSize;
        }
        
        void align(int _horizontal, int _vertical) {
            this.horizontal = _horizontal;
            this.vertical = _vertical;
            this.labelPos();
        }
        
        void labelPos() {
            if (this.labelSize > 0) {
                switch(this.horizontal) {
                    case CENTER:
                        this.labelX = this.x + this.width / 2;
                        break;
                    case LEFT:
                        this.labelX = this.x;
                        break;
                    case RIGHT:
                        this.labelX = this.x + this.width;
                        break;
                    default:
                        println("Warning:Invalid Align");
                        throw new RuntimeException();
                }
                switch(this.vertical) {
                    case CENTER:
                        this.labelY = this.y + this.height / 2;
                        break;
                    case TOP:
                        this.labelY = this.y;
                        break;
                    case BOTTOM:
                        this.labelY = this.y + this.height;
                        break;
                    default:
                        println("Warning:Invalid Align");
                        throw new RuntimeException();
                }
            }
        }
        
        void labelColor(color _textColor) {
            this.textColor = _textColor;
        }
        
        void labelFont(PFont _font) {
            this.font = _font;
        }
    }
    
    // ボタンのコンストラクタ
    Button(Object obj, String _buttonName, float _x, float _y, float _w, float _h, float _r) {
        papplet.registerMethod("draw", this);
        this.obj = obj;
        
        this.buttonName = _buttonName;
        // 初期値の設定
        set = new Set();
        this.set.position(_x, _y);
        this.set.size(_w, _h, _r);
        this.set.buttonColor(200, 0);
        this.set.buttonHoverColor(255);
        this.set.labelColor(0);
        this.set.label(_buttonName, 12);
        this.set.align(CENTER, CENTER);
        this.set.labelFont(fileIO.meiryoFont);
    }
    
    // ボタン表示関数
    void draw() {
        if (!visible) {
            return;
        }
        push();
        
        // ボタン自体（ラベル以外）を表示
        this.buttonShow();
        // ラベルを表示
        this.labelShow();
        
        // ボタンがクリックされたかを判別
        if (checkButtonClick()) {
            // クリックされたらclickButtonEvent関数を実行
            this.excution(this.buttonName);
        }
        
        pop();
    }
    
    // ボタン表示関数（ラベル以外）
    void buttonShow() {
        // ホバーしてないときの色
        if (!checkHover()) {
            fill(this.set.rectColor);
        }
        // ホバー時の色
        else {
            fill(this.set.rectHoverColor);
        }
        if (this.set.img == null) {
            stroke(this.set.rectEdgeColor);
            rect(this.set.x, this.set.y, this.set.width, this.set.height, this.set.radius);
        } else {
            image(this.set.img, this.set.x, this.set.y, this.set.width, this.set.height);
        }
    }
    
    // ラベル表示関数
    void labelShow() {
        textFont(this.set.font, this.set.labelSize);
        fill(this.set.textColor);
        textAlign(this.set.horizontal, this.set.vertical);
        text(this.set.textlabel, this.set.labelX, this.set.labelY);
    }
    
    // マウスがボタンにホバーしてるかの判別関数
    boolean checkHover() {
        if ((mouseX > this.set.x && mouseX < this.set.x + this.set.width) && 
            (mouseY > this.set.y && mouseY < this.set.y + this.set.height)) {
            return true;
        }
        return false;
    }
    
    // ボタンがクリックされたかの判別関数
    boolean checkButtonClick() {
        boolean return_flag = false;
        
        if (!this.checkHover()) {
            this.clickOnFlag = false;
            this.clickOldOnFlag = false;
        } else {
            if (!this.clickFlag) {
                this.clickOnFlag = mousePressed;
            }
            if (this.clickOldOnFlag && !mousePressed) {
                return_flag = true;
            }
            this.clickOldOnFlag = this.clickOnFlag;
        }
        if (!this.clickOnFlag)
            this.clickFlag = mousePressed;
        
        return return_flag;
    }
    
    void excution(String methodName) {
        try {
            Method m = this.obj.getClass().getDeclaredMethod(methodName);
            m.invoke(this.obj);
        }
        catch(NoSuchMethodException e) {
            println("Error: No function", methodName + "()");
            //throw new RuntimeException(e);
        }
        catch(NullPointerException e) {
            println("Error: No function", methodName + "()");
            //throw new RuntimeException(e);
        }
        catch(IllegalAccessException e) {
            throw new RuntimeException(e);
        }
        catch(InvocationTargetException e) {
            println("Error: Function is", methodName + "() in error");
            throw new RuntimeException(e);
        }
    }
    
    void visible(boolean disp) {
        this.visible = disp;
    }
}

// ここまでボタンライブラリ
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// 以下アニメーションテキストライブラリ

public class AnimationTextLib {
    float animationTime;
    boolean isSetComplete = false;
    float startTime;
    char[] charArray;
    float textPos;
    String textStack = "";
    int index;
    boolean visible = false;
    long watiStartTime;
    long waitTime;
    
    String text;
    float x;
    float y;
    float time;
    int mode;
    color c = color(0);
    
    AnimationTextLib() {
        papplet.registerMethod("draw", this);
    }
    
    void setColor(color _color) {
        this.c = _color;
    }
    
    //mode = 0のときdurationの時間内でテキストを表示する
    //mode = 1のとき1文字あたりintervalの時間(秒)でテキストを表示する
    void setText(String _text, float _x, float _y, float _time, int _mode, long _waitTime) {
        if (visible) {
            return;
        }
        this.text = _text;
        this.x = _x;
        this.y = _y;
        this.time = _time;
        this.mode = _mode;
        this.waitTime = _waitTime;
        setVisible(true);
        textStack = "";
        isSetComplete = false;
        watiStartTime = millis();
    }
    
    void setVisible(boolean _visible) {
        this.visible = _visible;
    }
    
    void draw() {
        if (!visible || millis() - watiStartTime <= waitTime) {
            return;
        }
        push();
        textFont(fileIO.meiryoFont);
        textSize(40);
        fill(c);
        switch(mode) {
            case 0:
                drawAnimationText(time * 1000 / (text.length() - 1));
                break;
            case 1:
                drawAnimationText(time * 1000);
                break;
        }
        pop();
    }
    
    //クラス外から呼ばない
    private void drawAnimationText(float _time) {
        textAlign(LEFT, CENTER);
        if (!isSetComplete) {
            startTime = millis();
            index = 0;
            isSetComplete = true;
        }
        if (index < text.length() && millis() - startTime >= _time * index) {
            charArray = text.toCharArray();
            textStack += charArray[index];
            text(textStack, x, y);
            index++;
        } else {
            text(textStack, x, y);
        }
    }
}

// ここまでアニメーションテキストライブラリ
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// ここからリストテキストライブラリ

public class ListTextLib {
    ArrayList<String> str;
    ArrayList<Boolean> needClick;
    boolean writerFlag = false;
    int writerNum;
    long startTime;
    long WATE_TIME = 100;
    float textSpeed;

    ListTextLib() {
        papplet.registerMethod("draw", this);
    }

    void setText(ArrayList<String> _str, ArrayList<Boolean> _needClick, float textSpeed) {
        this.str = _str;
        this.needClick = _needClick;
        needClick.add(true);
        writerNum = 0;
        writerFlag = true;
        startTime = millis();
    }
    
    void clearWriter() {
        writerFlag = false;
        if(str != null) {
            str.clear();
            needClick.clear();
        }
    }

    void draw() {
        if(!writerFlag || millis()-startTime <= WATE_TIME) {
            return;
        }
        if(!needClick.get(min(writerNum, needClick.size()-1))) {
            animationTextLib.setVisible(false);
            writerNum++;
            if(writerNum > str.size()) {
                writerFlag = false;
                return;
            }
            animationTextLib.setText(str.get(writerNum-1), 150, 615, textSpeed, 0, 0);
        }
    }

    void mouseClickPlay() {
        if(writerFlag) {
            needClick.set(writerNum, false);
        }
    }
}

// ここまでリストテキストライブラリ
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// ここから装飾テキストライブラリ

public class DecorationTextLib {
    DecorationTextLib() {
    }
    
    void shadowText(String text, float x, float y, color textColor, color shadowColor) {
        pushMatrix();
        translate(x, y);
        push();
        fill(shadowColor);
        text(text, -4, 2);
        fill(textColor);
        text(text, 0, 0);
        pop();
        popMatrix();
    }
}

// ここまで装飾テキストライブラリ
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// ここからオーディオライブラリ

public class ListAudioPlayer {
    ArrayList<AudioPlayer> voice;
    ArrayList<Boolean> needClick;
    boolean playFlag = false;
    int playerNum;
    long startTime;
    long WATE_TIME = 100;

    ListAudioPlayer() {
        papplet.registerMethod("draw", this);
    }

    void setAudio(ArrayList<AudioPlayer> _voice, ArrayList<Boolean> _needClick) {
        this.voice = _voice;
        this.needClick = _needClick;
        needClick.add(true);
        playerNum = 0;
        playFlag = true;
        startTime = millis();
    }
    
    void clearPlayer() {
        playFlag = false;
        if(voice != null) {
            voice.clear();
            needClick.clear();
        }
    }

    void draw() {
        if(!playFlag || millis()-startTime <= WATE_TIME) {
            return;
        }
        if(playerNum >= voice.size() && !voice.get(min(playerNum, voice.size()-1)).isPlaying() && !needClick.get(min(playerNum, needClick.size()-1))) {
            playFlag = false;
        }
        else if(!voice.get(max(playerNum-1, 0)).isPlaying() && !needClick.get(min(playerNum, needClick.size()-1))) {
            voice.get(playerNum).play(0);
            playerNum++;
        }
    }

    void mouseClickPlay() {
        if(playFlag) {
            needClick.set(playerNum, false);
        }
    }

    boolean isRemainPlaying() {
        return playFlag;
    }
}

// ここまでオーディオライブラリ
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// ここからforEachIndex
/*
<T>：ジェネリクス型 T
T：総称型(Type)
Set<データ型>
Map.Entry：keyとvalueのペア
enumerate:ユーザー定義クラス
Map<キーのデータ型, 値のデータ型> マップ名 = new LinkedHashMap<>();
※-----------
HashMapはその名前の通り、キーからハッシュ値を算出して管理するため、順序は不定となる。
TreeMapはキーの自然順序付けによってソートされる。
LinkedHashMapは、HashMapとLinkedListの両方で管理するため、挿入された順番を保持する。
-------------
*/

import java.lang.Iterable;
import java.util.Iterator;
import java.util.Arrays;

class Enumerator<T> {
    private final int index;
    private final T object;
    
    Enumerator(int index, T object) {
        this.index = index;
        this.object = object;
    }
    
    int getIndex() {
        return index;
    }
    
    T getObject() {
        return object;
    }
}

// ジェネリクス型の戻り値, 反復可能, 
<T> Iterable<Enumerator<T>> enumerate(final Iterable<T> iterable) {
    //匿名クラスで継承して返す
    return new Iterable<Enumerator<T>>() {
        // IterableがIteretorをオーバーライドしないと使えない
        public Iterator<Enumerator<T>> iterator() {
            return new Iterator<Enumerator<T>>() {
                private int index = 0;
                private Iterator<T> iterator = iterable.iterator();
                
                public boolean hasNext() {
                    // イテレーターインターフェイスのhasNext関数をオーバーライド？している
                    // 再起関数ではない, superのイメージ
                    return iterator.hasNext();
                }
                
                public Enumerator<T> next() {
                    return new Enumerator<T>(index++, iterator.next());
                }
            };
        }
    };
}

// ここまでforEachIndex
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// ここからフェイドインアウト

public class FadeInOut {
    boolean visible = false;
    final float FADE_SPEED = 0.1;
    int fadeMode;
    float alpha;
    float n;

    FadeInOut() {
        papplet.registerMethod("draw", this);
    }

    void set() {
        visible = true;
        alpha = 0.0;
        n = 0.0;
        fadeMode = 0;
    }

    void draw() {
        if(!visible) {
            return;
        }
        push();
        fill(0, alpha*255);
        rect(0, 0, width, height);
        if(fadeMode == 0) {
            n+=FADE_SPEED;
            if(n >= 1.0) {
                fadeMode = 1;
            }
        }
        else {
            n-=FADE_SPEED;
            if(alpha <= 0.0) {
                visible = false;
            }
        }
        alpha = sqrt(n);
        pop();
    }
}

// フェイドインアウト
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
//ここからパーティクル

class Particle {
    Point[] points;
    final int POINT_NUM = 30;
    boolean visible = false;
    long startTime;
    
    Particle() {
        points = new Point[POINT_NUM];
    }
    
    void setParticle(float x, float y) {
        for(int i=0; i<POINT_NUM; i++) {
            float theta = random(2*PI);
            points[i] = new Point(x, y, cos(theta)*random(0.5, 3), sin(theta)*random(0.5, 3), random(5, 10));
        }
        visible = true;
        startTime = millis();
    }
    
    void draw() {
        if(!visible) {
            return;
        }
        for(Point p : points) {
            p.draw();
            p.update();
        }
        if(millis() - startTime > 3000) {
            visible = false;
        }
    }
    
    class Point {
        PVector pos;
        PVector vec;
        float r;
        
        Point(float x, float y, float vx, float vy, float _r) {
            pos = new PVector(x, y);
            vec = new PVector(vx, vy);
            this.r = _r;
        }
        
        void draw() {
            fill(255);
            noStroke();
            circle(pos.x, pos.y, r);
        }
        
        void update() {
            pos.add(vec);
            vec.mult(0.90);
            r *= 0.95;
        }
    }
}

// ここまでパーティクル
//--------------------------------------------------------------------------------------
