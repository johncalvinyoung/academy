Feature: Playing a Game
	In my Go Fish app
	As a standard user
	I want to play a game

Scenario: Playing first game
	Given a new user
	When he signs up
	And he enters his address information
	Then he can start a new game
	When he starts a game
	Then he sees a new game with his name at the bottom

Scenario: Returning User
	Given a returning user
	When he logs in
	Then he sees his past stats
	And he starts a game
	Then he sees a new game with his name at the bottom

Scenario: User's Dashboard
	Given the user is logged in
	And he is on his dashboard
	Then he can start a new game
	And when he edits his profile
	Then he can see his address

Scenario: View User
	Given the user is logged in
	When you view his profile page
	Then you see his past stats
	And you cannot start a new game

Scenario: View User List
	Given the user is logged in
	And another user exists
	When you view the user list
	Then you can see their stats

Scenario: Game Win
	Given the user is logged in
	And a winning game
	When you view the end page
	Then the user is listed as winner

Scenario: Game Loss
	Given the user is logged in
	And a losing game
	When you view the end page
	Then a robot is listed as winner

Scenario: Game Tie
	Given the user is logged in
	And a tied game
	When you view the end page
	Then both tied players are listed as winners
	When you click the title
	Then you can see a tie in your stats
