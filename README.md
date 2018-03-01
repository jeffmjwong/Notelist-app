# Note List Terminal App

## Description
The Note List app is a simple yet powerful app for storing notes that you wrote
in external files and you can read back the notes in the terminal anytime with
ease.

## Plan
1. Draft a blueprint for the app we are building
2. Think about some basic functionalities of the app
3. Put the idea together and make a prototype with complete functionalities
4. Start writing code for the prototype app
5. Run and test the app to find potential bugs
6. Fix as many bugs as we can find
7. Refactor the source code and customisation for user experience
8. Continuous development, such as adding new features and bug fixes in the future

## Design
1. User Interface design includes welcome screen, menu options and meaningful response.
2. The app is built utilising object-orientated programming concept.
3. Classes are used to encapsulate methods and are stored in different file.
4. Main script will import class files and other required gems.
5. Rescue statements are implemented to avoid app from breaking by invalid user input.
6. Ruby plugins such as `Marshal` is used to handle reading and writing to external files.
7. This app focus on code functionalities as well as user experience, which makes it fun and trouble-free to use.

## Approach and Features
To use the app, make sure `notelist_app.rb` and `notelist_class.rb` is in the
same folder. `list.txt` is not necessary because the app will create it if it
does not exist. Example notes are stored in the `notes-folder` folder, and
you can actually add any full or relative path for the note file that you want
to add to the note list app. Before running the app, make sure to install the
following gems:
```
gem install terminal-table
gem install colorize
```
In the directory in which `notelist_app.rb` and `notelist_class.rb` are stored,
type `ruby notelist_app.rb` in the terminal to run the app. The main
functionalities of the note list app are:
```
'l' to show list
'a' to add note
'd' to delete note
'r' to read note
'q' to quit
```
Follow the prompt to use the app and enjoy!

## Google Drive Link Address
[https://docs.google.com/document/d/1Nwh81Ovimylg5KCRIIWq392VQ6RogBo0XpqengeJ6FY/edit?usp=sharing]
