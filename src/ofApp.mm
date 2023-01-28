#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(ofColor::white);
    ofSetFrameRate(20);
    
    //Set iOS to Orientation Landscape Right
    ofSetOrientation(OF_ORIENTATION_90_RIGHT);
    
    //old OF default is 96 - but this results in fonts looking larger than in other programs.
    ofTrueTypeFont::setGlobalDpi(72);
    
    // Loading Starting Screen Font
    ofTrueTypeFontSettings startingSettings("yeyey.ttf", 70);
    startingSettings.addRange(ofUnicode::Latin);
    startingSettings.addRange(ofUnicode::Latin1Supplement);
    startingFont.load(startingSettings);
    
    ofTrueTypeFontSettings musicalSetting("AppleGothic.ttf", 55);
    musicalSetting.addRange(ofUnicode::MiscSymbols);
    startingMusicFont.load(musicalSetting);
    
    // Load Instruction Font
    startingInstructionFont.load("circled.ttf", 25, true, true);
    
    // Loading Music Emoticon Font
    ofTrueTypeFontSettings settings("AppleGothic.ttf", 14);
    settings.addRange(ofUnicode::MiscSymbols);
    font.load(settings);
    
    // Load Message Font
    messageFont.load("sfpro.ttf", 17, true, true);
    
    // Determine if Retina
    if(ofGetWidth() > 480){ // then we are running retina
        retina = true;
    }
    
    // Loading/Playing BGM and Sound Effect
    bgm.load("hypnotic_puzzle.mp3");
    //bgm.play();
}

//--------------------------------------------------------------
void ofApp::update(){
    // Revert to Option Screen if past drawTimedLetters.
    if (screenChanger > 4) {screenChanger = 1;}
    
    // Revert to default timeIndicator unless on drawTimedLetters.
    if (screenChanger != 3) { timeIndicator = 10;}
    
    // Create bounds for timeIndicator flag.
    if (timeIndicator < 10) {timeIndicator  = 10;}
    if (timeIndicator > 1300) {timeIndicator = 1300;}
    
    // Ensure "bgm" is always playing.
    //if (!bgm.isPlaying()) {bgm.play();}
}

//--------------------------------------------------------------
void ofApp::draw(){
    if (retina) {ofScale(2.0, 2.0, 1.0);}
    
    if (screenChanger == 0) {showStartingScreen();}
    else if (screenChanger == 1) {showOptionScreen();}
    else if (screenChanger == 2) {drawBlitzMode();}
    else if (screenChanger == 3) {touchStart = true; drawTimedLetters(20);}
    else if (screenChanger == 4) {drawColorLetters(20);}
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    touchXCurrent = touch.x * 0.5;
    touchYCurrent = touch.y * 0.5;
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    if (touchStart) {movingFinger(touch);}
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    
    if (screenChanger == 1)
    {
        // Blitz Mode
        if (touch.x >= 0 && touch.x <= ofGetWidth()/2) {screenChanger = 2;}
        // Pull Mode
        else if (touch.x >= ofGetWidth()/2 && touch.x <= ofGetWidth()) {screenChanger = 3;}
    }
    
    else {screenChanger = 1;}
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}

//--------------------------------------------------------------
void ofApp::showStartingScreen()
{
    // Draw Head Title
    ofSetColor(ofColor::black);
    if (retina)
    {
        int xCoordinate = (ofGetWidth() * 0.5) / 3;
        int yCoordinate = (ofGetHeight() * 0.5) / 2;
        startingFont.drawString("OPERA", xCoordinate, yCoordinate);
        startingMusicFont.drawString("♪", xCoordinate + 255, yCoordinate - 5);
        ofSetColor(ofColor::pink);
        startingFont.drawString("HIT", xCoordinate + 310, yCoordinate);
        
        // Draw "Tap to Start" instruction.
        ofSetColor(ofColor::black);
        startingInstructionFont.drawString("DOUBLE TAP TO START", xCoordinate + 18, yCoordinate + 40);
    }
    
    else
    {
        int xCoordinate = ofGetWidth() / 3;
        int yCoordinate = ofGetHeight() / 2;
        startingFont.drawString("OPERA", xCoordinate, yCoordinate);
        startingMusicFont.drawString("♪", xCoordinate + 255, yCoordinate - 5);
        ofSetColor(ofColor::pink);
        startingFont.drawString("HIT", xCoordinate + 310, yCoordinate);
        
        // Draw "Tap to Start" instruction.
        ofSetColor(ofColor::black);
        startingInstructionFont.drawString("TAP TO START", xCoordinate + 100, yCoordinate + 40);
        
    }
}

//--------------------------------------------------------------
void ofApp::showOptionScreen()
{
    // Reset instruction loading.
    showInstruction = true;
    
    // Reset Blitz Mode Variables.
    resetGame = true;
    totalCount = 0;
    
    if (retina)
    {
        int newWidth = ofGetWidth() * 0.5;
        int newHeight = ofGetHeight() * 0.5;
        
        // Blitz Mode
        ofSetColor(ofColor::lavender);
        ofDrawRectangle(0, 0, newWidth/2, newHeight);
        ofSetColor(ofColor::black);
        int xBlitzCoordinate = (newWidth) / 2 / 2;
        int yBlitzCoordinate = newHeight / 2;
        startingInstructionFont.drawString("BLITZ MODE", xBlitzCoordinate, yBlitzCoordinate);
        
        // Pull Mode
        ofSetColor(ofColor::lightPink);
        ofDrawRectangle(newWidth/2, 0, newWidth/2, newHeight);
        ofSetColor(ofColor::black);
        int xPullCoordinate = (xBlitzCoordinate * 2) + (xBlitzCoordinate/2/2);
        int yPullCoordinate = newHeight/2;
        startingInstructionFont.drawString("PULL MODE", xPullCoordinate, yPullCoordinate);
        
    }
    else
    {
        // Blitz Mode
        ofSetColor(ofColor::lavender);
        ofDrawRectangle(0, 0, ofGetWidth()/2, ofGetHeight());
        ofSetColor(ofColor::black);
        startingInstructionFont.drawString("BLITZ MODE", ofGetWidth() / 4, ofGetHeight());
        
        // Pull Mode
        ofSetColor(ofColor::lightPink);
        if (retina)
        ofDrawRectangle(ofGetWidth()/2, 0, ofGetWidth()/2, ofGetHeight());
        ofSetColor(ofColor::black);
        startingInstructionFont.drawString("PULL MODE", (ofGetWidth() / 4) * 3, ofGetHeight() / 2);
    }
}

//--------------------------------------------------------------
string ofApp::getLetters(int number)
{
    int randomNumber = rand() % number;
    if (randomNumber == 0) {return "♭";}
    else if (randomNumber == 1) {return "♩";}
    else if (randomNumber == 2) {return "♪";}
    else if (randomNumber == 3) {return "♬";}
    else if (randomNumber == 4) {return "♭";}
    return "♭";
}

//--------------------------------------------------------------
void ofApp::drawColorLetters(int desiredCharacters)
{
    // Account for Retina Scale
    int widthScale = ofGetWidth() * 0.5;
    int heightScale = ofGetHeight() * 0.5;
    
    // Calculate Spacing
    int xSpacing = widthScale/desiredCharacters;
    int ySpacing = heightScale/ (desiredCharacters/2);
    
    // Print Characters
    for (int i = 30; i < widthScale; i += xSpacing)
    {
        for (int j = 30; j < heightScale; j += ySpacing)
        {
            // Bounding Rectangles
            int border = rand() % 3;
            ofSetColor(rand() % 255, rand() % 255, rand() % 255, 45);
            ofDrawRectRounded(i - 8, j - 20, 30, 30, 5);
            if (border == 0)
            {
                ofNoFill();
                ofSetColor(ofColor:: black);
                ofDrawRectRounded(i - 8, j - 20, 30, 30, 4);
                ofFill();
                
            }
            
            // Chracters
            ofSetColor(ofColor::black, rand() % 255);
            font.drawString(getLetters(5), i, j);
        }
    }
    
    // Message Box
    int startX = retina ? ofGetWidth() * 0.5 / 4 : ofGetWidth() / 4;
    int startY = retina ? ofGetHeight() * 0.5 / 3 : ofGetHeight() / 3;
    int messageWidth = retina ? (ofGetWidth() * 0.5 / 4) * 2 : (ofGetWidth()/4) * 2;
    int messageHeight = retina ? (ofGetHeight() * 0.5 / 3) : ofGetHeight() / 2;
    ofRectangle messageBox(startX, startY, messageWidth, messageHeight);
    
    ofSetColor(ofColor:: white);
    ofDrawRectRounded(messageBox, 5);
    ofSetColor(ofColor:: black);
    ofNoFill();
    ofDrawRectRounded(messageBox, 5);
    ofFill();
    messageFont.drawString("Congratulations you have finished Blitz Mode!", startX + 10, startY + 20);
    messageFont.drawString("We hope you had as much fun playing operaHit as we had making it.", startX + 10, startY + 40);
    messageFont.drawString("Double Tap to play again!", startX + 10, startY + 80);
    
    
    startingMusicFont.drawString("♪", startX + messageWidth - 100, startY + messageHeight - 20);
}

//--------------------------------------------------------------
void ofApp::drawBlitzMode()
{
    // Game Finished Flag
    if (totalCount == 25) {screenChanger = 4;}
    
    // Determine Bounds
    int xUpperBound = retina ? ofGetWidth() * 0.5 - 100 : ofGetWidth() - 100;
    int yUpperBound = retina ? ofGetHeight() * 0.5 - 100 : ofGetHeight() - 100;
    
    int xLowerBound = 100, yLowerBound = 100;
    
    // Draw Count Header
    string countWord = to_string(totalCount);
    int wordX = retina ? (ofGetWidth() * 0.5 / 2.3)  : ofGetWidth()/3;
    int wordY = retina ? (ofGetHeight() * 0.5 / 4) : ofGetHeight()/4;
    startingInstructionFont.drawString("COUNT " + countWord, wordX, wordY);
    
    // Instruction Handling
    if (totalCount >= 1) {showInstruction = false;}
    
    if (showInstruction){
        int startX = wordX - 75;
        int startY = wordY + 20;
        int instructionWidth = retina ? (ofGetWidth() * 0.5 / 4) : ofGetWidth() /4;
        int instructionHeight = retina ? (ofGetHeight() * 0.5 / 6.6) : ofGetHeight() / 6;
        
        ofRectangle instructionBox(startX, startY, instructionWidth, instructionHeight);
        
        ofSetColor(ofColor::white);
        ofDrawRectRounded(instructionBox, 5);
        ofSetColor(ofColor:: black);
        ofNoFill();
        ofDrawRectRounded(instructionBox, 5);
        ofFill();
        
        int sentenceX = retina ? startX + 10 : startX + 20;
        int sentenceY = retina ? startY + 20 : startY + 40;
        int yIncrementer = retina ? 20 : 40;
        messageFont.drawString("Tap the Notes!", sentenceX, sentenceY);
        messageFont.drawString("Double Tap to Exit.", sentenceX, sentenceY + yIncrementer);
        messageFont.drawString("Get to 25 for surprise...", sentenceX, sentenceY + 3 * yIncrementer);
    }

    
    // Get Random Instances
    if (resetGame){
        // Set Current Coordinates
        xCurrent = rand() % xUpperBound;
        yCurrent = rand() % yUpperBound;
        
        // Modify "x" if necessary
        if (xCurrent < xLowerBound) {xCurrent = xLowerBound;}
        if (yCurrent < yLowerBound) {yCurrent = yLowerBound;}
        if (yCurrent > wordY - 60 && yCurrent < wordY + 60) {yCurrent = wordY + 80;}
        if (showInstruction) {
            xCurrent = retina ? ofGetWidth() * 0.5 / 2 : ofGetWidth() /2;
            yCurrent = retina ? (ofGetHeight() * 0.5 / 2) + 100 : ofGetHeight() / 2 + 100;
        }
            
        
        // Set Current Colors
        currentColors.clear();
        currentColors.push_back(rand() % 255);
        currentColors.push_back(rand() % 255);
        currentColors.push_back(rand() % 255);
        currentColors.push_back(45);
        
        // Set Current Emoticon
        musicEmoticon = getLetters(5);
        
        resetGame = false;
    }
    
    // Draw Color Rectangle
    ofSetColor(currentColors[0], currentColors[1], currentColors[2], currentColors[3]);
    ofDrawRectRounded(xCurrent, yCurrent, 30, 30, 5);
    
    // Draw Rectangle Border
    ofNoFill();
    ofSetColor(ofColor::black);
    ofDrawRectRounded(xCurrent, yCurrent, 30, 30, 5);
    ofFill();
    
    // Draw Emoticon
    font.drawString(musicEmoticon, xCurrent + 8, yCurrent + 20);
        
    int xBoundingBox[] = {xCurrent - 50, xCurrent + 50};
    int yBoundingBox[] = {yCurrent - 50, yCurrent + 50};
        
    bool result = boundingBoxCheck(touchXCurrent, touchYCurrent, xBoundingBox, yBoundingBox);
    
    if (result) {totalCount++; resetGame = true;}
}

//--------------------------------------------------------------
void ofApp::drawTimedLetters(int desiredCharacters)
{
    // Calculate Spacing and Coordinates;
    int xCoordinate = 30;
    int yCoordinate = 30;
    
    
    int widthScale = ofGetWidth() > 480 ? ofGetWidth() * 0.5 : ofGetWidth();
    int heightScale = ofGetWidth() > 480 ? ofGetHeight() * 0.5 : ofGetHeight();
    
    int xSpacing = widthScale/desiredCharacters;
    int ySpacing = heightScale/ (desiredCharacters/2);
    
    // Calculate Maximum Number of Characters.
    int maximumCount = pow(desiredCharacters, 2) + 1;
    
    // Calculate Current Characters.
    int countIndicator = timeIndicator / 5;
    if (countIndicator > maximumCount) {countIndicator = maximumCount; done = true;}
    
    // Instruction Handling
    if (countIndicator > 5) {showInstruction = false;}
    
    if (showInstruction){
        int startX = retina ? (ofGetWidth() * 0.5 / 2) + (ofGetWidth() * 0.5 / 5) : (ofGetWidth() / 2) + (ofGetWidth() /5);
        int startY = retina ? (ofGetHeight() * 0.5 / 15) : ofGetHeight() / 4;
        int instructionWidth = retina ? (ofGetWidth() * 0.5 / 4) : ofGetWidth() /4;
        int instructionHeight = retina ? (ofGetHeight() * 0.5 / 8) : ofGetHeight() / 6;
        
        ofRectangle instructionBox(startX, startY, instructionWidth, instructionHeight);
        
        ofSetColor(ofColor::white);
        ofDrawRectRounded(instructionBox, 5);
        ofSetColor(ofColor:: black);
        ofNoFill();
        ofDrawRectRounded(instructionBox, 5);
        ofFill();
        
        int instructionX = retina ? startX + 10 : startX + 20;
        int instructionY = retina ? startY + 20 : startY + 40;
        int yIncrementer = retina ? 40 : 80;
        messageFont.drawString("Drag your finger to increase the notes!", instructionX, instructionY);
        messageFont.drawString("Double Tap to Exit.", instructionX, instructionY + yIncrementer);
    }
    
    for (int rowChar = 1; rowChar < countIndicator; rowChar++)
    {
        // (Row by Row)
        ofSetColor(rand() % 255, rand() % 255, rand() % 255, 45);
        
        // Draw Color Background Rectangles.
        ofDrawRectRounded(xCoordinate - 8, yCoordinate - 20, 30, 30, 5);
        
        // Draw Border Rectangles.
        ofNoFill();
        ofSetColor(ofColor::black);
        ofDrawRectRounded(xCoordinate - 8, yCoordinate - 20, 30, 30, 5);
        ofFill();
        
        // Draw String
        font.drawString(getLetters(5), xCoordinate, yCoordinate);
        xCoordinate += xSpacing;
            
        // Update if 20 Characters have been drawn.
        if (rowChar % desiredCharacters == 0) {yCoordinate += ySpacing; xCoordinate = 30;}
    }
}

//--------------------------------------------------------------
void ofApp::movingFinger(ofTouchEventArgs & touch)
{
    int distanceMoved;
    if (firstTouch) {startingTouch = touch.x; firstTouch = false;}
    
    // Calculate Distance.
    if (touch.id == 0) {distanceMoved = touch.x - startingTouch;}
    
    // Finger Moves Left.
    if (distanceMoved < 0)
    {
        // If TimeIndicator is already at max, return.
        if (done) {return;}
        timeIndicator = timeIndicator - 1 * (abs(distanceMoved)/50);
        
        // Account for change in finger direction.
        if (previousTouch < touch.x) {startingTouch = touch.x;}
    }
    
    // Finger Moved Right.
    else if (distanceMoved > 0)
    {
        if (done) {return;}
        timeIndicator = timeIndicator + 1 * (abs(distanceMoved)/50);
        
        // Account for change in finger direction.
        if (previousTouch > touch.x) {startingTouch = touch.x;}
    }
    
    // Update Previous Position.
    previousTouch = touch.x;
}
    
//--------------------------------------------------------------
bool ofApp::boundingBoxCheck(int xCoordinate, int yCoordinate, int xBoundingBox[], int yBoundingBox[])
{
    bool result = false;
    
        if (xCoordinate >= xBoundingBox[0] && xCoordinate <= xBoundingBox[1])
        {
            if(yCoordinate >= yBoundingBox[0] && yCoordinate <= yBoundingBox[1])
            {
                result = true;
            }
        }
    return result;
}

