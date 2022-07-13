# Tweet Tracker

Live demo: [Tweet Tracker](http://socialtrackr.herokuapp.com)

## About
Tweet Tracker is a Rails CRUD app that allows you to search for tweets by user's Twitter handle or by keywords, and save them for future reference.

Dependency
```
  gem 'twitter'
  gem 'omniauth'
  gem 'omniauth-twitter'
```

## API
  Retrieve 5 most recent tweets from an user timeline by making a GET request to `'http://socialtrackr.herokuapp.com/search/' + twitter_handle`

## Specs
   Omniauth authentication with Twitter.
   Use of Twitter API gem to fetch content.
   Two associated models, User and Tweet, with a many-to-many relationship.
   Nested resources between the two models `/users/:user_id/tweets/:tweet_id`

## Installation
Sign up at http://dev.twitter.com for an API key and API secret and put them in your environment. For example, in `~/.bash_profile`:

  export ST_TWITTER_KEY   ="[API key]"
  export ST_TWITTER_SECRET="[API secret]"

Or on heroku:
`heroku config:set ST_TWITTER_KEY ="[API key]" ST_TWITTER_SECRET="[API secret]`

## Development
- Start app: `$ bundle exec rails s`
- Create the database: `bin/rails db:create`
