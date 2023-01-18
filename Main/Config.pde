import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;

class Config {
    String appTitle;

    Config(String _appTitle) {
        this.appTitle = _appTitle;
        init();
    }

    void init() {
        surface.setIcon(fileIO.appIcon);
        surface.setTitle(appTitle) ;
        listAudioPlayer = new ListAudioPlayer();
        animationTextLib = new AnimationTextLib();
        listTextLib = new ListTextLib();
        decorationTextLib = new DecorationTextLib();
        fadeInOut = new FadeInOut();
    }
}