class Story implements Scene {
    Room[] roomList;
    final int START_ROOM = 6;
    int roomNum;
    Console console;
    Player player;
    String playerName = "kCat";
    Button button;
    boolean consoleFlag;

    Story() {
        /*---------------
        <--- ルーム番号 --->
        0 : 工房
        1 : R364
        2 : R493
        3 : 大講義室
        4 : 講堂
        5 : 食堂
        6 : 玄関
        ---------------*/
        roomList = new Room[]  {
            new CraftCenter(),
            new R364(),
            new R493(),
            new LargeClassRoom(),
            new Auditorium(),
            new LunchRoom(),
            new Entrance()
        };
        button = new Button(this, "visibleConsole", 1075, 10, 110, 40, 5);
        button.set.label("コンソール", 18);
        button.visible(false);
    }

    void setup() {
        console = new Console(this);
        player = new Player();
        button.visible(true);
        consoleFlag = true;
        roomNum = START_ROOM;
    }

    void draw() {
        roomList[roomNum].draw();
        player.draw();
        drawCommentArea();
        if(listAudioPlayer.isRemainPlaying()){
            drawTriangleNextButton();
        }
        if(consoleFlag) {
            console.draw();
        }
    }

    void drawCommentArea() {
        push();
        textFont(fileIO.rCornerFont);
        fill(#D9D9D9, 255*0.8);
        rect(100, 515, 1000, 190, 10);
        fill(#54A8F5);
        rect(75, 475, 250, 75, 10);
        fill(255);
        textSize(32);
        textAlign(CENTER, CENTER);
        text(playerName, 200, 510);
        pop();
    }

    void drawTriangleNextButton() {
        fill(0);
        noStroke();
        float CENTER_X = 1070;
        float CENTER_Y = 670;
        float HALF_LINE = 15;
        float HEIGHT = HALF_LINE*sqrt(3);
        float moveY = map(sin(frameCount/4.0), -1, 1, 0, 1)*10.0;
        CENTER_Y += moveY;
        triangle(CENTER_X-HALF_LINE, CENTER_Y-HEIGHT*0.33, CENTER_X+HALF_LINE, CENTER_Y-HEIGHT*0.33, CENTER_X, CENTER_Y+HEIGHT*0.66);
    }
    
    void close() {
        button.visible(false);
    }
    
    void visibleConsole() {
        consoleFlag = !consoleFlag;
    }

    void keyPressed() {
        console.keyPressed();
    }

    void keyReleased() {
        
    }

    void mousePressed() {
        animationTextLib.setVisible(false);
        listAudioPlayer.mouseClickPlay();
    }
}
