# Yellowtail

the social network for wine enthusiasts.

let's throw some grapes on the barby, mate

[Pour yourself a glass](https://rubyrose-yellowtail.herokuapp.com/)

### Bootstrapping
#### Part 1: Downloading the project
1. Open up the Terminal application and run this line to install the command line tools you'll need: `xcode-select --install`
2. Clone (download) the repository by running this line: 
`git clone https://github.com/rubyandrose/yellowtail.git`. You've just downloaded a personal copy
of your team's project!
3. Paste this line into your terminal: `cd bota-box` to enter the new directory you just created.

#### Part 2: Setting up your credentials
4. Paste this line into your terminal: `touch .env.local` - you'll create a new file. We'll use this file to store some credentials your app will need.
5. Now let's open that file up by pasting `open -a TextEdit .env.local` into your terminal.
6. Go to the #ruby-and-rose Slack channel and open up the pinned messages. Find the one with `GOOGLE_CLIENT_ID` and click on it.
7. Copy the contents of that message (both lines) into the file you opened in TextEdit and save the file. Close TextEdit.

#### Part 3: Installing the requirements
8. Now let's install all the things our project needs to run. Paste `script/setup.sh` into your terminal. This will start installing everything from the Ruby programming language to the database we're going to need to all the supporting tools that power our web app. This step may take a few minutes. If the script is still running after five minutes, grab a mentor.
9. Sometimes install scripts hit unexpected roadblocks. If you hit errors, grab a mentor.

#### Part 4: Profit
10. Assuming your script ran successfully, type `rails s` to start your app.
11. Open a new tab in your browser and go to `http://localhost:3000`. You should see a wine glass and a log in message. If so, you're all set!
