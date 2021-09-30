//Bad Spelling 
//Charlie Wong
//Jan 14, 2020
//declaring variables

//Character arrays: alphabet is for choosing random letters for grid,
// charArray is 2D array for positions of grid
char alphabet[] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
char charArray[][] = new char[5][5];

//Strings: typing is for user input, input is for user's confirmed input, dictionary contains all of the dictionary words
String typing = "";
String input = "";

//Booleans: marked is used for Search function so that it does not go back and check previous positions, 
// correct is used by drawBoard function to print the letters of word on grid in green,
// intro is used to remove starting screen once user has read instructions
// enterKey is used for when user presses enter and confirms word to search
boolean marked[][] = new boolean [5][5];
boolean correct[][] = new boolean [5][5];
boolean intro = true;
boolean enterKey = false;

//ArrayLists: foundWords is used to hold user's confirmed words, 
// wordCorrect is used to hold whether the words are in the grid or not
// inDictionary is used to hold whether words are in dictionary or not
// dictionary contains all of dictionary words
ArrayList<String> foundWords= new ArrayList();
ArrayList<Boolean> wordCorrect = new ArrayList();
ArrayList<Boolean> inDictionary = new ArrayList();
ArrayList<String> dictionary = new ArrayList();

void setup(){ //setup function that runs at beginning of program
  size(700,700); //sets size of display window
  textSize(32); //sets text size
  background(0); //sets background colour to black
  
  //nested for loops to set up arrays, runs through every position in the 2D arrays
  for (int i = 0; i < 5; i++){ 
    for (int j = 0; j < 5; j++){
      int z = int(random(26)); //random number to select from alphabet array
      charArray[i][j] = alphabet[z]; //charArray has random letters chosen from alphabet array
      marked[i][j] = false; //no positions are marked at beginning
      correct[i][j] = false; //no positions are correct at beginning
    }
  }
 
  //string to hold dictionary words
  String [] dictionaryStrings = loadStrings("dictionary.txt");
  
  //convert dictionary words to uppercase and transfer them to ArrayList dictionary, a global variable that can be used in all functions
  for (int k = 0; k < dictionaryStrings.length; k++){
    dictionaryStrings[k] = dictionaryStrings[k].toUpperCase();
    dictionary.add(dictionaryStrings[k]);
  }
  
}

void draw(){ //draw function that draws on display window, continuously runs code inside function
 clear(); //clears screen, so that nothing overlaps when screen is rewritten
 textAlign(CENTER); //centers text
 
 if(enterKey){ //if Enter key has been pressed
   findPaths(input + "*"); //added asterisk as search for path did not check last character otherwise
 } 
 drawBoard(); //run drawBoard function to show grid
 drawWords(); //run drawWords function to display other text
 
 if (intro){ //.if intro is true (by default on startup), then use drawIntro to display starting screen
   drawIntro();
 }
 
 drawExitButton(); //run drawExitButton to display button for quitting
 drawNewBoardButton(); //run drawResetButton to display button for generating new board
}

void drawExitButton(){ //drawExitButton is used to display button for quitting
  rectMode(CORNER); //set rectangle formatting to corner
  
  //if else statement for user's cursor - if cursor passes over button, it will change colour
  if (mouseX >= 600 && mouseY >= 670){
    fill(200);
  }
  else{
    fill(255);
  }
  
  rect(600, 670, 100, 30); //draw rectangle
  fill(0); //set colour to black
  textAlign(CENTER); //center text
  textSize(20);// set text size to 20
  text("QUIT",650,693); //display "QUIT" on top of the button
  fill(255); //set colour back to white
}

void drawNewBoardButton(){ //drawNewBoardButton is used to display button for generating new board (and resetting list of words)
  rectMode(CORNER); //set rectangle formatting to corner
  
  //if else statement for user's cursor - if cursor passes over button, it will change colour
  if (mouseX <= 125 && mouseY >= 670){
    fill(200);
  }
  else{
    fill(255);
  }

  rect(0, 670, 125, 30); //draw rectangle
  fill(0); //set colour to black
  textAlign(CENTER); //center text
  textSize(20); //set text size to 20
  text("NEW BOARD",62,693); //display "RESET" on top of the button
  fill(255); //set colour back to white
}

void drawBoard(){ //drawBoard function is used to display grid of letters
  textAlign(CENTER); //centers text
  textSize(32); //set text size to 32
  
  //nested for loops to run through and print letters
  for(int i = 0; i < 5; i++){ 
   for(int j = 0; j < 5; j++){
    if(correct[i][j]){ //if the position in the array is correct (correct array position is true), change text colour to green
      fill(0, 255, 0);
    }
    text(charArray[i][j], (i*50) + 250, (j*50)+250); //print letter (+250 for formatting)
    fill(255); //set colour back to white
   }
  }
}

void drawIntro(){ //drawIntro function is used to display intro message/instructions
  textAlign(CENTER); //centers text
  textSize(32); //set text size to 32
  fill(0); //fill is black
  rect(0,0,700,700); //draw black rectangle covering screen
  fill(255); //set colour to white
  
  //display instructions
  text("Click anywhere on the screen to start.\nThen, type a word in.\nPress the Enter key\nwhen you have chosen your word.\nProgram will then begin search.\nClick QUIT button to quit.\nClick NEW BOARD button\nto generate new board.", 350,200);
}

void drawWords(){ //drawWords function is used to display other text on screen besides grid of letters
  textAlign(LEFT); //aligns text to left
  textSize(32); //set text size to 32
  fill(255); //sets colour to white
  text("Your Word: " + typing,25,50); //display "Your Word: " and user's input. updates as user types in letters
  text("Searching for: " + input,25,100); //display "Searching for: " and user's confirmed word
  textSize(15); //set text size to 15
  text("In Grid? ",25,250); //display "In Grid? "
  text("In Dictionary?", 500,250); //display "In Dictionary?"
  
  textSize(12); //set text size to 12
  //prints messages saying:
  // "GREEN = word is in grid"
  // "RED = word is not in grid"
  // "GREEN = word is in dictionary"
  // "RED = word isn't in dictionary"
  fill(0,255,0); 
  text("GREEN",25,270); 
  text("GREEN",500,270);
  fill(255); 
  text(" = word is in grid",65,270); 
  text(" = word is in dictionary", 540, 270);
  fill(255,0,0);
  text("RED",25,290);
  text("RED",500,290);
  fill(255);
  text(" = word is not in grid",65,290);
  text(" = word isn't in dictionary",540,290);
  
  textSize(15); //set text size to 15
  for (int z = 0; z < foundWords.size(); z++){ //for loop runs through ArrayList foundWords and prints words out as list on screen
    if (wordCorrect.get(z) == false){ //if wordCorrect position is false, display word in red
      fill(255,0,0);
    }
    else if (wordCorrect.get(z) == true){ //if wordCorrect position is true, display word in green
      fill(0,255,0);
    }
    text(foundWords.get(z),25,(z*15) + 330); //display word
    fill(255); //set colour back to white
  }
  
  for (int z = 0; z < foundWords.size(); z++){ //for loop runs through ArrayList foundWords and prints words out as list on screen
    if (inDictionary.get(z) == false){ //if inDictionary position is false, display word in red
      fill(255,0,0);
    }
    else if (inDictionary.get(z) == true){ //if inDictionary position is true, display word in green
      fill(0,255,0);
    }
    text(foundWords.get(z),500,(z*15) + 330); //display word
    fill(255); //set colour back to white
  }
  
}
 
void keyPressed() { //when user presses a key
  if (key == '\n' ) { //if user presses Enter key
    input = typing; //input becomes what user has typed in
    typing = ""; //typing resets
    enterKey = true; //enterKey is true, used elsewhere
    Unmark(); //calls Unmark to reset marked array
    Uncorrect(); //calls Uncorrect to reset correct array
    foundWords.add(input); //add user's word to list of words
    wordCorrect.add(false); //default is that user's word is not found
    inDictionary.add(false); //default is that user's word is not in dictionary
    dictionaryCheck(); //call dictionary check function
  }
  else if (key == '\b' && typing.length() > 0){ //if user presses backspace and the typing string is not empty
    typing = typing.substring(0,typing.length()-1); //remove last character from typing string
  }
  else if(key != '\b'){ //user presses any other keys
    enterKey = false; //user has not pressed enter
    typing = typing + key; //typing string is equal to previously entered characters + key user just pressed
    typing = typing.toUpperCase(); //typing string is converted to uppercase
  }
}

void mouseClicked(){ //if mouse is clicked, intro is false, so intro screen disappears and game can start
  intro = false;
  if(mouseX >= 600 && mouseY >= 670){ //if mouse is clicked in quit game button area, end program
    exit();
  }
  
  if(mouseX <= 125 && mouseY >= 670){ //if mouse is clicked in new board button area, create new board
    NewGrid();
  }
}

boolean findPaths(String input){ //function to check if user's word is in grid, takes user's word as input
  boolean foundAPath = false; //sets boolean foundAPath as false
 
 //nested for loop to run through all of positions in array to find first character of word
  for(int i = 0; i < 5; i++){
   for(int j = 0; j < 5; j++){
     if(charArray[i][j] == input.charAt(0)){ //if position in array is first character of word
      marked[i][j] = true; //set marked as true, so Search function will not check that position in array
      correct[i][j] = true; //set correct as true (for displaying in green)
      if(Search(i, j, 1, input)){ //call Search function with position of first character, next position to check for in user word, and user's word
       foundAPath = true; //if Search returns true, then foundAPath is also true
       wordCorrect.set(wordCorrect.size()-1,true); //set user's word true (display in green on list of words)
      }else{ //if Search returns false
       marked[i][j] = false; //unmark position 
       correct[i][j] = false; //change position back to incorrect
      }
     }
     
     Unmark(); //unmark all positions for next word
     
   }
  }
 
  return foundAPath; //return bool foundAPath
}

boolean Search(int uno, int duo, int pos, String input){ //search function, takes in uno and duo as position in array, pos is position in user's word, input is user's word
  boolean gottem = false; //bool to return is set as false
  if(pos >= input.length() - 1){ //if position is greater than or equal to input length - 1, return true
   return true;
  }
  
  //nested for loops to run through all positions in charArray around the given position
  for(int i = uno - 1; i < uno + 2; i++){ //from one position behind to one position in front
   for(int j = duo - 1; j < duo + 2; j++){ //from one position behind to one position in from
    if(i > -1 && i < 5 && j > -1 && j < 5 && (i != uno || j != duo)){ //if the position is not out of the array and is not in the original position
     if(marked[i][j] == false){ //if the position is not marked
      if(charArray[i][j] == input.charAt(pos)){ //if character at position in grid is same as character at current position of user's word
        marked[i][j] = true; //mark position as marked
        correct[i][j] = true; //mark position as correct (used to print as green in drawBoard function)
        if(Search(i, j, pos+1, input)){ //recursively calling Search function, moving position in user's word over 1
          gottem = true; //if it can find all positions in user word, bool gottem is true
        }else{
         correct[i][j] = false; //if it cannot find all positions, unmark correct positions (changing them to false)
        }
      }
     }
    } 
   }
  }
  return gottem; //return bool gottem
}

void Uncorrect(){ //resets all correct array positions to false
  for (int i = 0; i < 5; i++){
    for (int j = 0; j < 5; j++){
      correct[i][j] = false;
    }
  }
}

void Unmark(){ //resets all marked array positions to false
  for (int i = 0; i < 5; i++){
    for (int j = 0; j < 5; j++){
      marked[i][j] = false;
    }
  }
}

void dictionaryCheck(){ //function to check if word is valid word in dictionary
  for(int i = 0; i < dictionary.size(); i++){ //for loop to run through all words in dictionary to compare to user word
    if (dictionary.get(i).equals(input)){ // if a word is found that matches user input
      inDictionary.set(foundWords.size()-1,true); //array inDictionary is set to true, so will display word in green
      break; //exit out of loop
    }
  }
  
}

void NewGrid(){ //new grid function, resets everything and generates new random grid of letters
  
  for (int i = 0; i < 5; i++){ 
    for (int j = 0; j < 5; j++){
      int z = int(random(26)); //random number to select from alphabet array
      charArray[i][j] = alphabet[z]; //charArray has random letters chosen from alphabet array
      marked[i][j] = false; //no positions are marked at beginning
      correct[i][j] = false; //no positions are correct at beginning
    }
  }
  foundWords.clear(); //clear ArrayList of words
  wordCorrect.clear(); //clear ArrayList of whether words are in grid or not
  inDictionary.clear(); //clear ArrayList of whether words are in dictionary or not
  
  typing = ""; //typing string is reset
  input = ""; //input string is reset
}
