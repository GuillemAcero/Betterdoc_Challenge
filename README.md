# BetterdocChallenge

Standalone web application that allows us to store relevant data in the context of a case identified by a
case identifier provided as query parameter called case_id.

# Getting Started
## Pre-requisites

  * Elixir v1.7 or higher
  * Docker and Docker compose
  * NodeJS
  * NPM

## Setup

Download the code

```
$ git clone https://github.com/GuillemAcero/Betterdoc_Challenge.git
```
Create DB docker instance
```bash
$ docker-compose up -d
```
Get all deps
```bash
$ mix deps.get
```
Setup the database
```bash
$ mix ecto.setup
```
Install phoneix packages
```bash
$ cd betterdoc_challenge/assets
$ npm install
$ cd ..
```
Run the phoenix server to start using the application at `localhost:4000`
```bash
$ mix phx.server
```

# Points of intereset

* `localhost/4000` works as the landing page showing all the cases
* The logo in the heades works as a redirect to the landing page
* The buttion 'contacts' redirect to `~/cases/case_id` showing all the contacts of this case (in case it have them)
* From `~/cases/case_id` page it's possible to create new contacts, edit existing ones or delete it.
* In `~/cases/case_id`, `~/contacts/edit/id` and `~/contacts/new` a 'back' button allow the user to go back to the previous page it was.

# Service deployment
As requested in the challenge, the easiest way to deploy this web application service could be using a docker instance like used in the database.

# WIP
As the challenge was meant to be done in +- 8 hours some things were not finished:

## User authentication
The user authentication using JWT was started, but due to time reasons i couldn't finish it. 
Even that an important part of the task is done in the following branch: 

`https://github.com/GuillemAcero/Betterdoc_Challenge/tree/user_auth`

This branch includes the model Accounts with it's basic functions, like creating and account using the lib Argon2 as encryptation method. 

Was planning to use 'Guardiand' and 'Ueberauth' to manage the session and registration controllers with it's views. It's possible to go to `localhost:4000/login` and `localhost:4000/register` and check the form to do those actions (not fully implemented yet)

## Flash Messages
Right now, when some action doesn't work, the app just redirect the user to the  landing page / contacts page  without telling the user if everythings went okay or something failed. I wanted to add flash messages, but they did not show properly, because of that i decided just to mark it as a #TODO task and continue with more important things.

## Audit Logging
Another thing i didn't had time to. Anyways i had in mind what i wanted to do, something like everytime a change is done by a user send a notification to a rabbit queue containing all the info requested in the challenge, and will work like a publish-subscribe pattern.
With that we can connect any external service we want to that RabbitMQ queue and if in the future more data / acctions needed to be tracked we can just add more type of messages, plus more than one external servie can be connected.

That was the main idea.


