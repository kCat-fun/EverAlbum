import ddf.minim.*;

Config conf;
Minim minim;
FileIO fileIO;
ListAudioPlayer listAudioPlayer;
AnimationTextLib animationTextLib;
ListTextLib listTextLib;
DecorationTextLib decorationTextLib;
FadeInOut fadeInOut;
App app;

void setup() {
    frameRate(60);
    size(1200, 750);
    minim = new Minim(this);
    fileIO = new FileIO();
    conf = new Config("Ever Album");
    app = new App();
}

void draw() {
    app.run();
}

void keyPressed() {
    if(key == ESC) {
        exit();
    }
    app.keyPressed();
}

void keyReleased() {
    app.keyReleased();
}

void mousePressed() {
    app.mousePressed();
}
