# Tweet Tracker

Live demo: [Tweet Tracker](http://socialtrackr.herokuapp.com)

## About
Tweet Tracker is a Rails CRUD app that allows you to search for tweets by user's Twitter handle or by keywords, and save them for future reference.

Dependency `gem 'twitter'`

## Installation
Sign up at http://dev.twitter.com for an API key and API secret and put them in your environment. For example, in `~/.bash_profile`:

export TWITTER_KEY   ="[API key]"
export TWITTER_SECRET="[API secret]"

Or on heroku:
`heroku config:set TWITTER_KEY ="[API key]" TWITTER_SECRET="[API secret]`
