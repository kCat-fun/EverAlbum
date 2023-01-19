class FileIO {
    // 要素（画像, 音楽等）の変数宣言
    // --- フォント -----
    PFont yuzuFont;
    PFont rCornerFont;
    PFont gothicFont;
    PFont meiryoFont;
    PFont msGothicFont;

    // --- 画像 -----
    // 素材画像
    PImage appIcon;
    PImage titleImg;
    PImage transitionImg;
    PImage characterImg;
    // 部屋の写真
    PImage craftCenterImg;
    PImage r364Img;
    PImage r495Img;
    PImage largeClassRoom;
    PImage auditorium;
    PImage lunchRoom;
    PImage entranceImg;

    // --- 音声 ---
    // セリフ
    AudioPlayer[] roomVoice;
    AudioPlayer[] subjectVoice;       // 科目
    AudioPlayer[] actionVoice;        // 行動
    AudioPlayer[] robotVoice;         // ロボット制作
    AudioPlayer[] processingVoice;    // 情報表現基礎課題
    AudioPlayer youtubeVoice;
    AudioPlayer twitterVoice;

    FileIO() {
        init();
    }

    // 要素（画像, 音楽等）の読み込み
    void init() {
        // ----- フォント -----
        yuzuFont = createFont("./font/ゆず ポップ A ver.0.6/ゆず ポップ A [M] Regular.ttf", 24);
        rCornerFont = createFont("HG丸ｺﾞｼｯｸM-PRO", 24);
        gothicFont = createFont("HGｺﾞｼｯｸM", 24);
        meiryoFont = createFont("Meiryo UI", 24);
        msGothicFont = createFont("ＭＳ ゴシック", 24);

        // ----- 画像 -----
        // アイコン画像
        appIcon = loadImage("image/character.png");
        // タイトル画像
        titleImg = loadImage("image/title.jpg");
        titleImg.resize(width, height);
        // トランジション時背景画像
        transitionImg = loadImage("image/transitionImg.jpg");
        transitionImg.resize(width, height);
        // キャラクター画像（立ち絵）
        characterImg = loadImage("image/character.png");
        // 部屋の写真
        craftCenterImg = loadImage("image/craftCenter.jpg");
        craftCenterImg.resize(width, height);
        r364Img = loadImage("image/r364.jpg");
        r364Img.resize(width, height);
        r495Img = loadImage("image/r495.jpg");
        r495Img.resize(width, height);
        largeClassRoom = loadImage("image/largeClassRoom.jpg");
        largeClassRoom.resize(width, height);
        auditorium = loadImage("image/auditorim.jpg");
        auditorium.resize(width, height);
        lunchRoom = loadImage("image/lunchRoom.jpg");
        lunchRoom.resize(width, height);
        entranceImg = loadImage("image/entrance.jpg");
        entranceImg.resize(width, height);

        // ----- 音声 -----
        /*--- 詳細 -------
            0, CraftCenter      : 工房
            1, R364             : R364
            2, R493             : R493
            3, LargeClassRoom   : 大講義室
            4, Auditorium       : 講堂
            5, LunchRoom        : 食堂
            6, Entrance         : 玄関
        */
        roomVoice = new AudioPlayer[] {
            minim.loadFile("sound/CraftCenter.wav"),
            minim.loadFile("sound/R364.wav"),
            minim.loadFile("sound/R493.wav"),
            minim.loadFile("sound/LargeClassRoom.wav"),
            minim.loadFile("sound/Auditorium.wav"),
            minim.loadFile("sound/LunchRoom.wav"),
            minim.loadFile("sound/Entrance.wav")
        };
        /*--- 詳細 -------
            0, InfoDesign          : 情報表現基礎
            1, ProgrammingBasic    : プロ基礎
            2, AnalysisMath        : 解析学
            3, Electronics         : 電子工学基礎
            4, Psychology          : 心理学
        */
        subjectVoice = new AudioPlayer[] {
            minim.loadFile("sound/InfoDesign.wav"),
            minim.loadFile("sound/ProgramminBasic.wav"),
            minim.loadFile("sound/AnalysisMath.wav"),
            minim.loadFile("sound/Electronics.wav"),
            minim.loadFile("sound/Psychology.wav")
        };
        /*--- 詳細 -------
            0, moving   : ～に来たぞ
            1, learning : ～の授業を受ける
            2, sending  : ～の課題を提出したぞ
            3, eatting  : お昼ご飯を食べた
            4, backHome : 今日も頑張った！家に帰ろう！
        */
        actionVoice = new AudioPlayer[] {
            minim.loadFile("sound/moving.wav"),
            minim.loadFile("sound/learning.wav"),
            minim.loadFile("sound/sending.wav"),
            minim.loadFile("sound/eatLunch.wav"),
            minim.loadFile("sound/backHome.wav")
        };
        // ロボットのセリフ
        robotVoice = new AudioPlayer[] {
            minim.loadFile("sound/robot0.wav"),
            minim.loadFile("sound/robot1.wav")
        };
        // Processing(情報表現基礎)のセリフ
        processingVoice = new AudioPlayer[] {
            minim.loadFile("sound/processing0.wav"),
            minim.loadFile("sound/processing1.wav"),
            minim.loadFile("sound/processing2.wav")
        };
        // 外部アプリ起動時音声
        twitterVoice = minim.loadFile("sound/twitter.wav");
        youtubeVoice = minim.loadFile("sound/youtube.wav");
    }
}