# Roosmarks

A self-hosted bookmarking service, similar(ish) to [delicious][], [pinboard][] and probably others.

I'm going to use this project to explore some ideas I've got about how bookmarking services might be more useful to me.

I currently have a version hosted on [Heroku][] at [roosmarks][].

## Development

### Pre-requisites

* [Ruby][]
* [Rubygems][] and [Bundler][]
* [libxml2][] and [libxslt][] (for Nokogiri)
* [PostgreSQL][]

### Getting started

    $ bundle install
    $ rake db:create:all
    $ rake db:migrate
    $ script/rails s # or
    $ foreman start

## Deploying to Heroku

    $ heroku create --stack cedar
    $ heroku config:add ROOSMARKS_USERNAME=your-username-here
    $ heroku config:add ROOSMARKS_PASSWORD=your-password-here
    $ git push heroku master
    $ heroku run rake db:migrate

[delicious]: http://delicious.com/
[pinboard]: http://pinboard.in/
[roosmarks]: http://roosmarks.herokuapp.com/
[Ruby]: http://www.ruby-lang.org/
[Rubygems]: http://rubyforge.org/projects/rubygems/
[Bundler]: http://gembundler.com/
[PostgreSQL]: http://www.postgresql.org/
[Heroku]: http://www.heroku.com/
[libxml2]: http://xmlsoft.org/
[libxslt]: http://xmlsoft.org/xslt/
