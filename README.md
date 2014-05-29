#GameGettr
==========

GA WDI DC April 2014, Project 1

##Overview

**GameGettr** is a web application to suggest possible video games to a user based on their response to several questions. GameGettr is a Ruby on Rails project completed as project one for the April 2014 Web Development Immersive course at General Assembly. This app was developed over a 5 day sprint and made use of the agile software development process.

##Technologies Used

* Ruby 2.1.1
* Ruby on Rails 4.1.1
* PostgreSQL Database
* Authentication & Authorization from scratch using [bcrypt-ruby](http://bcrypt-ruby.rubyforge.org/)
* [GamesRadar](http://dl.gamesradar.com/api/GamesRadar_Developer_API_Documentation.pdf) & [GiantBomb](http://www.giantbomb.com/api/documentation) search APIs
    Along with [HTTParty](https://github.com/jnunemaker/httparty)
* Testing using using [rspec-rails](https://github.com/rspec/rspec-rails), [capybara](https://github.com/jnicklas/capybara), [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) and [factory_girl_rails](https://github.com/thoughtbot/factory_girl_rails).

##User Stories Completed

* A user should land on a dynamic homepage that will give them specific options based on their status (signed in or not).
* If not a member, a user should be able to sign up.
* If not signed in, a user should be able to sign in.
* Once signed in, a user can sign out.
* A user can answer several questions and be presented with a list of games based off their answers.
* A user can select a specific game from the presented list and be redirected to a page wiht greater details.
* A user can choose to add a specific game to their own personal list of games.
* A user can see greater game details by selecting a game in their personal list.
* A user can remove a game from their personal list.

##Backlog

A full list of user stories can be found by looking at [this Pivotal Tracker Project](https://www.pivotaltracker.com/s/projects/1086728)

##ERD

!https://github.com/rmlatz/game_gettr/tree/master/public/ERD.png
