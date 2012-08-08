Feature: Playing a Game
	In
	As
	I

Scenario: Playing first game
	Given a new user
	When he signs up
	Then he can start a new game
	When he starts a game
	Then he sees a new game with his name at the bottom

Scenario: Returning User
	Given a returning user
	When he enters his name
	Then he sees his past stats
	And he starts a game
	Then he sees a new game with his name at the bottom

Scenario: View User
	Given a returning user
	When you view his profile page
	Then you see his past stats
	And you cannot start a new game

Scenario: View User List
	Given two returning users
	When you view the user list
	Then you can see their stats

Scenario: Game Win
	Given a winning game
	When you view the end page
	Then the user is listed as winner

Scenario: Game Loss
	Given a losing game
	When you view the end page
	Then a robot is listed as winner
