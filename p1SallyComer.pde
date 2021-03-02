/**
*Sally Comer
*/

import controlP5.*;

ControlP5 cp5;

Textlabel myTextlabelA;
Textlabel myTextlabelB;
int n = 0;
String enteredNumbers = "";
int timerMinutes = 0;
int timerSeconds = 0;
int state = 0;
/*
0: clock mode
1: entering digits for cook time
2: cook time running
3: cook time paused
4: cook time ended
*/
int frameWhenStarted = 0;

void setup() {
  println(frameRate);
  frameRate(30);
  size(700,400);
  cp5 = new ControlP5(this);
  cp5.addButton("buttonOne").setPosition(500, 150).setSize(30, 30).setLabel("1");
  cp5.addButton("buttonTwo").setPosition(535, 150).setSize(30, 30).setLabel("2");
  cp5.addButton("buttonThree").setPosition(570, 150).setSize(30, 30).setLabel("3");
  cp5.addButton("buttonFour").setPosition(500, 185).setSize(30, 30).setLabel("4");
  cp5.addButton("buttonFive").setPosition(535, 185).setSize(30, 30).setLabel("5");
  cp5.addButton("buttonSix").setPosition(570, 185).setSize(30, 30).setLabel("6");
  cp5.addButton("buttonSeven").setPosition(500, 220).setSize(30, 30).setLabel("7");
  cp5.addButton("buttonEight").setPosition(535, 220).setSize(30, 30).setLabel("8");
  cp5.addButton("buttonNine").setPosition(570, 220).setSize(30, 30).setLabel("9");
  cp5.addButton("buttonZero").setPosition(535, 255).setSize(30, 30).setLabel("0");
  
  cp5.addButton("buttonStart").setPosition(500, 255).setSize(30, 30).setLabel("->");
  cp5.addButton("buttonStop").setPosition(570, 255).setSize(30, 30).setLabel(">||");
  
  myTextlabelA = new Textlabel(cp5, "mode", 100, 50, 400, 200);
  myTextlabelB = new Textlabel(cp5, "time", 100,100,400,200);

}

void draw() {
  background(0);
  if (state == 2) {
    int framesElapsed = frameCount - frameWhenStarted;
    if (framesElapsed > 0) {
      if ((framesElapsed % 30) == 0) {
        decrementTimer();
      }
    }
  }
  String modeString = "";
  switch (state) {
    case 0:
    modeString = "CLOCK";
    break;
    case 1:
    modeString = "ENTER COOK TIME";
    break;
    case 2:
    modeString = "COOKING";
    break;
    case 3:
    modeString = "PAUSED";
    break;
    case 4:
    modeString = "ENDED";
    default:
    modeString = "unknown mode";
  }
  myTextlabelA.setText(modeString);
  myTextlabelA.draw(this);
  myTextlabelB.setText(createTimeString());
  myTextlabelB.draw(this); 
  
  
}

public String createTimeString() {
  switch (state) {
    case 0:
    return str(hour()) + ":" + nfs(minute(), 2);
    case 1:
    int numbersLength = enteredNumbers.length();
    if (numbersLength == 1) {
      timerMinutes = 0;
      timerSeconds = int(enteredNumbers);
    } else {
      timerSeconds = int(enteredNumbers.substring(numbersLength-2, numbersLength));
      timerMinutes = int(enteredNumbers.substring(0, numbersLength - 2));
    }
    case 2:
    case 3:
    return str(timerMinutes) + ":" + nfs(timerSeconds, 2);
    case 4:
    return "DONE";
    default:
    return "unimplemented string for state";
  }

}

public void decrementTimer() {
  if (timerSeconds == 0) {
    if (timerMinutes > 0) {
      timerMinutes--;
      timerSeconds = 59;
    } else {
      state = 4;
      enteredNumbers = "";
    }
  } else {
    timerSeconds--;
  }
}


public void numberPressed() {
  switch (state) {
    case 0:
    state = 1;
    break;
    case 1:
    state = 1;
    break;
    default:
  }
}

public void buttonOne(int theValue) {
  enteredNumbers = enteredNumbers + "1";
  numberPressed();
}
public void buttonTwo(int theValue) {
  enteredNumbers = enteredNumbers + "2";
  numberPressed();
}
public void buttonThree(int theValue) {
  enteredNumbers = enteredNumbers + "3";
  numberPressed();
}
public void buttonFour(int theValue) {
  enteredNumbers = enteredNumbers + "4";
  numberPressed();
}
public void buttonFive(int theValue) {
  enteredNumbers = enteredNumbers + "5";
  numberPressed();
}
public void buttonSix(int theValue) {
  enteredNumbers = enteredNumbers + "6";
  numberPressed();
}
public void buttonSeven(int theValue) {
  enteredNumbers = enteredNumbers + "7";
  numberPressed();
}
public void buttonEight(int theValue) {
  enteredNumbers = enteredNumbers + "8";
  numberPressed();
}
public void buttonNine(int theValue) {
  enteredNumbers = enteredNumbers + "9";
  numberPressed();
}
public void buttonZero(int theValue) {
  if (state == 1) {
    enteredNumbers = enteredNumbers + "0";
  numberPressed();
  }
}

public void buttonStart(int theValue) {
  switch (state) {
    case 0:
    case 4:
    enteredNumbers = "30";
    timerSeconds = 30;
    state = 2;
    frameWhenStarted = frameCount;
    break;
    case 1:
    state = 2;
    frameWhenStarted = frameCount;
    break;
    case 2:
    if (timerSeconds > 29) {
      timerMinutes++;
      timerSeconds -= 30;
    } else {
      timerSeconds += 30;
    }
    break;
    case 3:
    state = 2;
    frameWhenStarted = frameCount;
    break;
    default:
  }
  
}
public void buttonStop(int theValue) {
  switch (state) {
    case 0:
    break;
    case 1:
    enteredNumbers = "";
    state = 0;
    break;
    case 2:
    state = 3;
    break;
    case 3:
    timerSeconds = 0;
    timerMinutes = 0;
    enteredNumbers = "";
    state = 0;
    case 4:
    state = 0;
    default:
  }
}
