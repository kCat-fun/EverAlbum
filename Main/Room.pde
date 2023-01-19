abstract class Room {
    String roomName;
    String[] catList;
    PImage bgImage;

    abstract void draw();
}

class CraftCenter extends Room {
    CraftCenter() {
        this.roomName = "工房";
        this.catList = new String[] {
        };
        this.bgImage = fileIO.craftCenterImg;
    }

    void draw() {
        image(this.bgImage, 0, 0);
    }
}

class R364 extends Room {
    R364() {
        this.roomName = "R364";
        this.catList = new String[] {
            "Psychology"
        };
        this.bgImage = fileIO.r364Img;
    }

    void draw() {
        image(this.bgImage, 0, 0);
    }
}

class R493 extends Room {
    R493() {
        this.roomName = "R493";
        this.catList = new String[] {
            "InfoDesign",
            "ProgramminBasic"
        };
        this.bgImage = fileIO.r495Img;
    }

    void draw() {
        image(this.bgImage, 0, 0);
    }
}

class LargeClassRoom extends Room {
    LargeClassRoom() {
        this.roomName = "大講義室";
        this.catList = new String[] {
            "AnalysisMath"
        };
        this.bgImage = fileIO.largeClassRoom;
    }

    void draw() {
        image(this.bgImage, 0, 0);
    }
}

class Auditorium extends Room {
    Auditorium() {
        this.roomName = "講堂";
        this.catList = new String[] {
            "Electronics"
        };
        this.bgImage = fileIO.auditorium;
    }

    void draw() {
        image(this.bgImage, 0, 0);
    }
}

class LunchRoom extends Room {
    LunchRoom() {
        this.roomName = "食堂";
        this.catList = new String[] {
        };
        this.bgImage = fileIO.lunchRoom;
    }

    void draw() {
        image(this.bgImage, 0, 0);
    }
}

class Entrance extends Room {
    Entrance() {
        this.roomName = "玄関";
        this.catList = new String[] {
        };
        this.bgImage = fileIO.entranceImg;
    }

    void draw() {
        image(this.bgImage, 0, 0);
    }
}