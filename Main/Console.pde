class Console {
    Story story;
    String[] cmdLog;
    int cmdLineNum;
    int logLineNum;
    HashMap<String, Command> cmdList;
    
    final String PATH_STRING = "kCat@home:$";
    final float WIDTH = 650;
    final float HEIGHT = 400;
    final int MAX_STRING = 37;
    final int FLASH_SPAN = 50;
    final int MAX_LINE_NUM = 9;
    
    Console(Story _story) {
        this.story = _story;
        logLineNum = 0;
        cmdLineNum = 0;
        cmdLog = new String[9];
        for(int i=0; i<MAX_LINE_NUM; i++) {
            cmdLog[i] = "";
        }
        cmdLog[0] = PATH_STRING;
        cmdList = new HashMap<String, Command>() {
            {
                put("cd", new ChangeDirectory());
                put("clear", new Clear());
                put("ls", new ListSegments());
                put("touch", new Touch());
                put("pwd", new PrintWorkingDirectory());
                put("ftp", new FileTransferProtocol());
                put("cat", new Concatenate());
                put("exit", new Exit());
                put("open", new Open());
                put("import", new Import());
                put("return", new Return());
            }
        };
    }
    
    void draw() {
        push();
        fill(0, 255*0.85);
        rect(100, 50, WIDTH, HEIGHT, 5);
        fill(255);
        textFont(fileIO.msGothicFont, 32);
        textAlign(LEFT, TOP);
        for(Enumerator<String> e : enumerate(Arrays.asList(cmdLog))) {
            text(e.getObject(), 120, 70+e.getIndex()*40);
        }
        pop();
        drawCursor();
    }

    void drawCursor() {
        fill(255);
        stroke(255);
        strokeWeight(2);
        // 文字の幅 + コンソールのx座標 + 調整分
        float left = cmdLog[cmdLineNum].length()*16 + 100 + 25;
        // コンソールのy座標 + 一番上の文字までの距離 + 行数分 + 調整分
        float top = 50 + 70 + (cmdLineNum-1)*40 - 10;
        // カーソルは通常時点滅, 文字入力時常時点灯
        if(frameCount % FLASH_SPAN*2 < FLASH_SPAN || keyPressed) {
            line(left, top, left, top+32);
        }
    }

    // 全体を上に1行ズらす（一番上が消える）をn回繰り返す
    void consoleLineUp(int n) {
        for(int counter=0; counter<n; counter++) {
            for(int i=0; i<MAX_LINE_NUM-1; i++) {
                cmdLog[i] = cmdLog[i+1];
            }
            cmdLog[MAX_LINE_NUM-1] = "";
            cmdLineNum--;
        }
    }

    // 適切いズらす関数
    void autoConsoleLineUp(int lineNum) {
        for(int i=0; i<lineNum; i++) {
            if(cmdLineNum+i+1 >= MAX_LINE_NUM) {
                consoleLineUp(lineNum-i);
            }
        }
    }

    
    void runCommand(ArrayList<String> cmd) {
        animationTextLib.setVisible(false);
        // substringでPath部分(kCat@home:$)を削除
        String cmdName = cmd.get(0).substring(11, cmd.get(0).length());
        // 存在しないコマンドを使用した場合の処理
        if(!cmdList.containsKey(cmdName)) {
            // 一番下の行を超すとき上に上げて調整
            autoConsoleLineUp(2);

            cmdLineNum++;
            cmdLog[cmdLineNum] = "error: \""+cmdName+"\" command does not exist";
            return;
        }
        cmd.remove(0);
        // コマンド第一引数の名前で検索しrunメソッドを実行
        cmdList.get(cmdName).run(this, cmd);
    }
    
    void keyPressed() {
        if(keyCode == ENTER) {
            // コマンド実行
            ArrayList<String> cmd = new ArrayList<String>();
            for(String s : split(cmdLog[cmdLineNum], ' ')) {
                cmd.add(s);
            }
            runCommand(cmd);
            // コマンド実行後更新
            cmdLineNum++;
            cmdLog[cmdLineNum] = PATH_STRING;
            logLineNum = cmdLineNum;
        }
        else if(keyCode == BACKSPACE) {
            if (cmdLog[cmdLineNum].length() > 11) {
                cmdLog[cmdLineNum] = cmdLog[cmdLineNum].substring(0, cmdLog[cmdLineNum].length()-1);
            }
        }
        else {
            // アルファベットor数字or空白（スペースキー）のキーなら入力を受け付ける
            if(('A' <= keyCode && keyCode <= 'Z') || ('0' <= keyCode && keyCode<='9') || key == ' ') {
                if(cmdLog[cmdLineNum].length() < MAX_STRING) {
                    cmdLog[cmdLineNum] += key;
                }
            }
            // 上キーを押してコマンドを巻き戻す
            else if(keyCode == UP) {
                logLineNum = constrain(logLineNum-1, 0, cmdLineNum);
                if(cmdLog[logLineNum].contains(PATH_STRING)) {
                    cmdLog[cmdLineNum] = cmdLog[logLineNum];
                }
                else {
                    do {
                        logLineNum--;
                    } while(!cmdLog[logLineNum].contains(PATH_STRING));
                    cmdLog[cmdLineNum] = cmdLog[logLineNum];
                }
            }
            // 下キーを押してコマンドを先に進める
            else if(keyCode == DOWN) {
                logLineNum = constrain(logLineNum+1, 0, cmdLineNum);
                if(cmdLog[logLineNum].contains(PATH_STRING)) {
                    cmdLog[cmdLineNum] = cmdLog[logLineNum];
                }
                else {
                    do {
                        logLineNum++;
                    } while(!cmdLog[logLineNum].contains(PATH_STRING));
                    cmdLog[cmdLineNum] = cmdLog[logLineNum];
                }
                if(cmdLineNum == logLineNum) {
                    cmdLog[cmdLineNum] = PATH_STRING;
                }
            }
        }
    }
}
