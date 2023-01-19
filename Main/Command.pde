abstract class Command {
    final float TEXT_SPEED = 1.0; 

    /*---------------
    <--- ルーム番号 --->
    0 : 工房
    1 : R364
    2 : R495
    3 : 大講義室
    4 : 講堂
    5 : 食堂
    6 : 玄関
    ---------------*/
    String[] roomNameList = new String[] {
        "CraftCenter",
        "R364",
        "R493",
        "LargeClassRoom",
        "Auditorium",
        "LunchRoom",
        "Entrance"
    };
    /*---------------
    <--- 教科番号 --->
        0, InfoDesign          : 情報表現基礎
        1, ProgrammingBasic    : プロ基礎
        2, AnalysisMath        : 解析学
        3, Electronics         : 電子工学基礎
        4, Psychology          : 心理学
    ---------------*/
    HashMap<String, String> subjectNameList = new HashMap<String, String>() {
        {
            put("InfoDesign", "情報表現基礎");
            put("ProgramminBasic", "プロ基礎");
            put("AnalysisMath", "解析学");
            put("Electronics", "電子工学基礎");
            put("Psychology", "心理学");
        }
    };
    String[] subjectName = new String[] {
        "InfoDesign",
        "ProgrammingBasic",
        "AnalysisMath",
        "Electronics",
        "Psychology"
    };
    
    abstract void run(Console con, ArrayList<String> cmd);
    
    // 引数の数にエラーがあればtrueを返す
    boolean errorArguments(Console con, ArrayList<String> cmd, int n) {
        // 引数がnを超過していれば
        if(cmd.size() > n) {
            con.cmdLineNum++;
            con.cmdLog[con.cmdLineNum] = "error: too many arguments";
            // 一番下の行を超すとき上に上げて調整
            con.autoConsoleLineUp(2);
            return true;
        }
        else if(cmd.size() < n) {
            con.cmdLineNum++;
            con.cmdLog[con.cmdLineNum] = "error: too few arguments";
            // 一番下の行を超すとき上に上げて調整
            con.autoConsoleLineUp(2);
            return true;
        }
        return false;
    }
}

class ChangeDirectory extends Command {
    ChangeDirectory() {
    }

    void run(Console con, ArrayList<String> cmd) {
        // 部屋移動確認フラグ
        boolean flag = false;
        // コマンド実行
        if(!errorArguments(con, cmd, 1)) {
            con.autoConsoleLineUp(1);
            for(int i=0; i<super.roomNameList.length; i++) {
                if(super.roomNameList[i].equals(cmd.get(0))) {
                    con.story.roomNum = i;
                    animationTextLib.setText(con.story.roomList[con.story.roomNum].roomName+"に移動してきた", 150, 615, super.TEXT_SPEED, 0, 500);
                    ArrayList<AudioPlayer> audioList = new ArrayList<AudioPlayer>();
                    audioList.add(fileIO.roomVoice[i]);
                    audioList.add(fileIO.actionVoice[0]);
                    ArrayList<Boolean> needClick = new ArrayList<Boolean>();
                    needClick.add(false);
                    needClick.add(false);
                    listAudioPlayer.setAudio(audioList, needClick);
                    flag = true;
                    fadeInOut.set();
                    break;
                }
            }
        }

        if(!flag) {
            con.autoConsoleLineUp(2);
            con.cmdLineNum++;
            con.cmdLog[con.cmdLineNum] = "error: \""+cmd.get(0)+"\" does not exist";
        }

        // デバッグ用出力
        println("ArrayList :", cmd);
        println("run cd command!");
        print("Arguments: ");
        for (String str : cmd) {
            print(str,"");
        }
        println();
        println("This room :", con.story.roomList[con.story.roomNum].roomName);
    }
}

class Clear extends Command {
    Clear() {
    }

    void run(Console con, ArrayList<String> cmd) {
        // コマンド実行
        if(!errorArguments(con, cmd, 0)) {
            for(int i=0; i<con.MAX_LINE_NUM; i++) {
                con.cmdLog[i] = "";
            }
            con.cmdLineNum = -1;
        }

        // デバッグ用出力
        println("run clear command!");
        print("Arguments: ");
        for (String str : cmd) {
            print(str,"");
        }
        println("");
    }
}

class ListSegments extends Command {
    ListSegments() {
    }

    void run(Console con, ArrayList<String> cmd) {
        // コマンド実行
        if(!errorArguments(con, cmd, 0)) {
            con.autoConsoleLineUp(3);
            con.cmdLineNum++;
            if(con.cmdLineNum > con.MAX_LINE_NUM) {

            }
            for(String roomName : super.roomNameList) {
                if(con.cmdLog[con.cmdLineNum].length()+roomName.length() >= con.MAX_STRING) {
                    con.cmdLineNum++;
                }
                con.cmdLog[con.cmdLineNum] += roomName+" ";
            }
        }

        // デバッグ用出力
        println("run ls command!");
        print("Arguments: ");
        for (String str : cmd) {
            print(str,"");
        }
        println("");
    }
}

class Touch extends Command {
    Touch() {
    }

    void run(Console con, ArrayList<String> cmd) {
        // コマンド実行
        if(!errorArguments(con, cmd, 1)) {
            con.autoConsoleLineUp(1);
            ArrayList<AudioPlayer> audioList = new ArrayList<AudioPlayer>();
            ArrayList<String> strList = new ArrayList<String>();
            ArrayList<Boolean> needClick = new ArrayList<Boolean>();

            if(cmd.get(0).equals("Robot")) {
                con.autoConsoleLineUp(1);
                audioList.add(fileIO.robotVoice[0]);
                audioList.add(fileIO.robotVoice[1]);
                needClick.add(false);
                needClick.add(true);
                strList.add("今度室工で開催されるサッカーロボットコンテストに出場する");
                strList.add("そのためのロボットを作っているところだ");
            }
            else if(cmd.get(0).equals("Processing")) {
                con.autoConsoleLineUp(1);
                audioList.add(fileIO.processingVoice[0]);
                audioList.add(fileIO.processingVoice[1]);
                audioList.add(fileIO.processingVoice[2]);
                needClick.add(false);
                needClick.add(true);
                needClick.add(true);
                strList.add("今は情報表現基礎のための作品を作っている");
                strList.add("Twitterを見ているとみんな苦しんでいるようだ");
                strList.add("期末試験の勉強もあるし早く完成させよう");
            }
            else {
                con.autoConsoleLineUp(2);
                con.cmdLineNum++;
                con.cmdLog[con.cmdLineNum] = "error: \""+cmd.get(0)+"\" does not exist";
            }
            if(audioList.size() > 0) {
                listAudioPlayer.setAudio(audioList, needClick);
                listTextLib.setText(strList, needClick, super.TEXT_SPEED);
            }
        }
        // デバッグ用出力
        println("run touch command!");
        print("Arguments: ");
        for (String str : cmd) {
            print(str,"");
        }
        println("");
    }
}

class PrintWorkingDirectory extends Command {
    PrintWorkingDirectory() {
        
    }

    void run(Console con, ArrayList<String> cmd) {
        // コマンド実行
        if(!errorArguments(con, cmd, 0)) {
            con.autoConsoleLineUp(2);
            con.cmdLineNum++;
            con.cmdLog[con.cmdLineNum] = "Path:kCat@home/"+super.roomNameList[con.story.roomNum];
        }

        // デバッグ用出力
        println("run pwd command!");
        print("Arguments: ");
        for (String str : cmd) {
            print(str,"");
        }
        println("");
    }
}

class FileTransferProtocol extends Command {
    FileTransferProtocol() {
    }

    void run(Console con, ArrayList<String> cmd) {
        // コマンド実行
        if(!errorArguments(con, cmd, 1)) {
            con.autoConsoleLineUp(1);
            ArrayList<AudioPlayer> audioList = new ArrayList<AudioPlayer>();
            ArrayList<String> strList = new ArrayList<String>();
            ArrayList<Boolean> needClick = new ArrayList<Boolean>();
            animationTextLib.setText(subjectNameList.get(cmd.get(0))+"の課題を提出したぞ", 150, 615, super.TEXT_SPEED, 0, 0);
            boolean flag = false;
            int i;
            for(i=0; i<subjectName.length; i++) {
                if(cmd.get(0).equals(subjectName[i])) {
                    flag = true;
                    break;
                }
            }
            if(flag) {
                audioList.add(fileIO.subjectVoice[i]);
                audioList.add(fileIO.actionVoice[2]);
                needClick.add(false);
                needClick.add(false);
                listAudioPlayer.setAudio(audioList, needClick);
            }
        }

        // デバッグ用出力
        println("run ftp command!");
        print("Arguments: ");
        for (String str : cmd) {
            print(str,"");
        }
        println("");
    }
}

class Concatenate extends Command {
    Concatenate() {
    }

    void run(Console con, ArrayList<String> cmd) {
        // コマンド実行
        if(!errorArguments(con, cmd, 1)) {
            con.autoConsoleLineUp(1);
            ArrayList<AudioPlayer> audioList = new ArrayList<AudioPlayer>();
            ArrayList<String> strList = new ArrayList<String>();
            ArrayList<Boolean> needClick = new ArrayList<Boolean>();
            animationTextLib.setText(subjectNameList.get(cmd.get(0))+"の授業を受けるところだ", 150, 615, super.TEXT_SPEED, 0, 0);
            boolean flag = false;
            int i;
            for(i=0; i<subjectName.length; i++) {
                if(cmd.get(0).equals(subjectName[i])) {
                    flag = true;
                    break;
                }
            }
            if(flag) {
                audioList.add(fileIO.subjectVoice[i]);
                audioList.add(fileIO.actionVoice[1]);
                needClick.add(false);
                needClick.add(false);
                listAudioPlayer.setAudio(audioList, needClick);
            }
        }

        // デバッグ用出力
        println("run cat command!");
        print("Arguments: ");
        for (String str : cmd) {
            print(str,"");
        }
        println("");
    }
}

class Import extends Command {
    Import() {
    }
    
    void run(Console con, ArrayList<String> cmd) {
        // コマンド実行
        if(!errorArguments(con, cmd, 0)) {
            con.autoConsoleLineUp(1);
            ArrayList<AudioPlayer> audioList = new ArrayList<AudioPlayer>();
            ArrayList<String> strList = new ArrayList<String>();
            ArrayList<Boolean> needClick = new ArrayList<Boolean>();
            needClick.add(false);
            audioList.add(fileIO.actionVoice[3]);
            strList.add("お昼ご飯を食べた");
            listAudioPlayer.setAudio(audioList, needClick);
            listTextLib.setText(strList, needClick, super.TEXT_SPEED);
        }

        // デバッグ用出力
        println("run import command!");
        print("Arguments: ");
        for (String str : cmd) {
            print(str,"");
        }
        println("");
    }
}

class Return extends Command {
    Return() {
    }
    
    void run(Console con, ArrayList<String> cmd) {
        // コマンド実行
        if(!errorArguments(con, cmd, 0)) {
            con.autoConsoleLineUp(1);
            ArrayList<AudioPlayer> audioList = new ArrayList<AudioPlayer>();
            ArrayList<String> strList = new ArrayList<String>();
            ArrayList<Boolean> needClick = new ArrayList<Boolean>();
            needClick.add(false);
            audioList.add(fileIO.actionVoice[4]);
            strList.add("今日も一日頑張った！家に帰ろう！");
            listAudioPlayer.setAudio(audioList, needClick);
            listTextLib.setText(strList, needClick, super.TEXT_SPEED);
        }

        // デバッグ用出力
        println("run return command!");
        print("Arguments: ");
        for (String str : cmd) {
            print(str,"");
        }
        println("");
    }
}

class Exit extends Command {
    Exit() {
    }

    void run(Console con, ArrayList<String> cmd) {
        // コマンド実行
        if(!errorArguments(con, cmd, 0)) {
            con.autoConsoleLineUp(1);
            animationTextLib.setVisible(false);
            app.changeScene(0);
        }

        // デバッグ用出力
        println("run exit command!");
        print("Arguments: ");
        for (String str : cmd) {
            print(str,"");
        }
        println("");
    }
}

class Open extends Command {
    Open() {
    }

    void run(Console con, ArrayList<String> cmd) {
        // コマンド実行
        if(!errorArguments(con, cmd, 1)) {
            con.autoConsoleLineUp(1);
            ArrayList<AudioPlayer> audioList = new ArrayList<AudioPlayer>();
            ArrayList<String> strList = new ArrayList<String>();
            ArrayList<Boolean> needClick = new ArrayList<Boolean>();
            needClick.add(false);
            switch(cmd.get(0)) {
                case "Twitter":
                    audioList.add(fileIO.twitterVoice);
                    strList.add("Twitterが見たくなった");
                    listAudioPlayer.setAudio(audioList, needClick);
                    listTextLib.setText(strList, needClick, super.TEXT_SPEED);
                    launch(dataPath("openTwitter.bat"));
                    break;
                case "YouTube":
                    audioList.add(fileIO.youtubeVoice);
                    strList.add("YouTubeが見たくなった");
                    listAudioPlayer.setAudio(audioList, needClick);
                    listTextLib.setText(strList, needClick, super.TEXT_SPEED);
                    launch(dataPath("openYouTube.bat"));
                    break;
                default:
                    con.autoConsoleLineUp(2);
                    con.cmdLineNum++;
                    con.cmdLog[con.cmdLineNum] = "error: \""+cmd.get(0)+"\" does not exist";
                    break;
            }
        }

        // デバッグ用出力
        println("run twitter command!");
        print("Arguments: ");
        for (String str : cmd) {
            print(str,"");
        }
        println("");
    }
}
