class Title implements Scene {
    Button playButton;
    Button exitButton;

    Title() {
        playButton = new Button(this, "play", (width-250)/2, 540, 250, 65, 15);
        exitButton = new Button(this, "finish", (width-250)/2, 630, 250, 65, 15);
        playButton.set.label("Play", 32, fileIO.gothicFont);
        exitButton.set.label("Exit", 32, fileIO.gothicFont);
        playButton.visible(false);
        exitButton.visible(false);
    }

    void setup() {
        playButton.visible(true);
        exitButton.visible(true);
    }

    void draw() {
        push();
        image(fileIO.titleImg, 0, 0);
        textFont(fileIO.yuzuFont);
        textSize(92);
        textAlign(CENTER, CENTER);
        decorationTextLib.shadowText(conf.appTitle, width/2, 100, color(0), color(255));
        pop();
    }

    void play() {
        app.changeScene(1);
    }

    void finish() {
        exit();
    }
    
    void close() {
        playButton.visible(false);
        exitButton.visible(false);
    }

    void keyPressed() {
    } 

    void keyReleased() {}

    void mousePressed() {
        
    }
}
