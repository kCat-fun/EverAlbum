class Player{
    PVector pos;
    PImage cImg;

    Player() {
        this.cImg = fileIO.characterImg;
        this.pos = new PVector(width/2+200, height-cImg.height);
    }

    void draw() {
        push();
        image(cImg, pos.x, pos.y);
        pop();
    }

    void keyPressed() {
    }

    void keyReleased() {
    }
}
