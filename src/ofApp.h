#pragma once

#include "ofxiOS.h"
#include "ofxGui.h"

class ofApp : public ofxiOSApp {
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);
        void movingFinger(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
        void showStartingScreen();
        void showOptionScreen();
        void drawBlitzMode();
        void drawColorLetters(int desiredCharacters);
        void drawTimedLetters (int desiredCharacters);
        string getLetters(int number);
    
        // Helper Functions
        bool boundingBoxCheck(int xCoordinate, int yCoordinate, int xBoundingBox[], int yBoundingBox[]);
    private:
        // Starting Screen Fonts
        ofTrueTypeFont startingFont;
        ofTrueTypeFont startingInstructionFont;
        ofTrueTypeFont startingMusicFont;
        ofTrueTypeFont messageFont;
    
        // Colorful Letters Font;
        ofTrueTypeFont font;
    
        // BGM Player
        ofSoundPlayer bgm;
    
        // Flag to keep track of Timed Letters/ Retina.
        bool retina = false, done = false;
        double timeIndicator = 10;
        double maxTimeIndicator;
    
        // Screen Changer / Instruction
        int screenChanger = 0;
        bool showInstruction = true;
    
        // Flags to indicate whether to start "movingFinger".
        bool touchStart = false;
    
        // ScreenChanger 2 Components
        vector<int> currentColors;
        string musicEmoticon;
        int totalCount = 0;
        bool resetGame = true;
    
        // Screen Changer 3 Components
        int startingTouch, previousTouch;
        bool firstTouch = true;
    
    
    
        // Current Touch Coordiantes
        int xCurrent, yCurrent;
        int touchXCurrent = 0, touchYCurrent = 0;
};


