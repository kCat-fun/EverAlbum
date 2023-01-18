class App {
    Particle particle;
    Scene[] sceneList;
    // 0:title, 1:Story
    int scene = 0;
    // シーン遷移するごとにsetupFlagをfalseにする
    boolean setupFlag = true;
    // トランジションのセットアップ用フラグ
    boolean sceneChangeFlag = false;
    // 1(ms)なので1000で1秒
    final long TRANSITION_TIME = 2500;
    long transitionStartTime;
    int transitionPoint = 0;

    App() {
        particle = new Particle();
        noStroke();
        sceneList = new Scene[] {
            new Title(), 
            new Story()
        };
    }

    void run() {
        if (setupFlag) {
            // sceneクラス内のsetup関数を実行
            sceneList[scene].setup();
            // シーン遷移後一度だけsetup関数を実行しsetupFlagをfalseにすることで以降実行されなくする
            setupFlag = false;
        }
        // シーン遷移中
        if (sceneChangeFlag) {
            transition();
            // トランジション開始時間+トランジション継続時間 <= 現在時間
            if (transitionStartTime + TRANSITION_TIME <= millis()) {
                // sceneChangeFlag = false にすることでelseの方が実行されトランジションが終了する
                sceneChangeFlag = false;
                setupFlag = true;
            }
        }
        // シーン描画中
        else {
            push();
            sceneList[scene].draw();
            pop();
        }
        particle.draw();
    }

    // シーン遷移用関数
    void changeScene(int n) {
        transitionStartTime = millis();
        sceneChangeFlag = true;
        sceneList[scene].close();
        scene = n;
    }

    // トランジション描画
    void transition() {
        push();
        // background(0);
        image(fileIO.transitionImg, 0, 0, width, height);
        textFont(fileIO.meiryoFont);
        // textAlign(CENTER, CENTER);
        // textSize(50);
        // text("Transition", width / 2, height / 2);
        textAlign(RIGHT, BOTTOM);
        textSize(40);
        noStroke();
        decorationTextLib.shadowText("LOADING   ", width - 5, height - 5, color(255), color(10));
        if (frameCount % 15 == 0) {
            transitionPoint = 3<transitionPoint ? 0 : ++transitionPoint;
        }
        switch(transitionPoint) {
        case 1:
            decorationTextLib.shadowText(".  ", width - 5, height - 5, color(255), color(10));
            break;
        case 2:
            decorationTextLib.shadowText(".. ", width - 5, height - 5, color(255), color(10));
            break;
        case 3:
            decorationTextLib.shadowText("...", width - 5, height - 5, color(255), color(10));
            break;
        }
        pop();
    }

    void keyPressed() {
        if (!sceneChangeFlag) {
            sceneList[scene].keyPressed();
        }

        /* --- デバッグ用 ---
        // 左矢印を押すと Story -> Title の順で遷移していく
        if (keyCode == 'L') {
            changeScene(scene-1 < 0 ?  sceneList.length - 1 : scene-1);
        }
        // 右矢印を押すと Title -> Story の順で遷移していく
        else if (keyCode == 'R') {
            changeScene(scene+1 > sceneList.length - 1 ?  0 : scene+1);
        } else if (!sceneChangeFlag) {
            sceneList[scene].keyPressed();
        }
        */
    }

    void keyReleased() {
        if (!sceneChangeFlag) {
            sceneList[scene].keyReleased();
        }
    }

    void mousePressed() {
        particle.setParticle(mouseX, mouseY);
        if (!sceneChangeFlag) {
            sceneList[scene].mousePressed();
        }
    }

    void dispose() {
    }
}
