# Roosmarks [![Build Status](https://secure.travis-ci.org/chrisroos/roosmarks.png?branch=master)](http://travis-ci.org/chrisroos/roosmarks)

A self-hosted bookmarking service, similar(ish) to [delicious][], [pinboard][] and probably others.

I'm going to use this project to explore some ideas I've got about how bookmarking services might be more useful to me.

I currently have a version hosted on [Heroku][] at [roosmarks][].

## Using Javascript to retrieve a bookmark

    url = 'https://roosmarks.herokuapp.com/bookmarks/'
    url = url + encodeURIComponent(document.location.href)
    var req = new XMLHttpRequest();
    req.onload = function() {
      console.log(this.responseText);
    };
    req.open('get', url, true)
    req.setRequestHeader('Accept', 'application/json')
    req.send()

## Development

### Pre-requisites

* [Ruby][] 1.9.2 or above
* [Rubygems][] and [Bundler][]
* [libxml2][] and [libxslt][] (for [Nokogiri][])
* [sqlite3][] development headers (for [Taps][])
* [PostgreSQL][] (I've tested successfully with 9.1 on Mac and FreeBSD)
* [NodeJS][] (for [ExecJS][] on FreeBSD)

### Getting started

    $ bundle install
    $ rake db:create:all
    $ rake db:migrate
    $ script/rails s # or
    $ echo RACK_ENV=development > .env
    $ foreman start

## Deploying to Heroku

You'll need the [Heroku Toolbelt](https://toolbelt.heroku.com/) in order to deploy to Heroku.

    $ git clone https://github.com/chrisroos/roosmarks.git
    $ cd roosmarks
    $ heroku apps:create your-chosen-app-name-here
    $ heroku config:add ROOSMARKS_USERNAME=your-username-here
    $ heroku config:add ROOSMARKS_PASSWORD=your-password-here
    $ git push heroku master
    $ heroku run rake db:migrate

All being well, you've now got your own copy of Roosmarks running on Heroku. You can visit it at http://your-chosen-app-name-here.herokuapp.com.

## FreeBSD specific installation notes

I had to jump through some hoops to get this running on FreeBSD 8.2:

    # Set PACKAGESITE to point to FreeBSD 8 stable packages so that we can get postgresql 9.1
    # (The latest postgresql package for my FreeBSD 8.2 release is 9.0, which caused me problems)
    $ setenv PACKAGESITE ftp://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-8-stable/Latest/

    # Installing libxml2, libxslt, postgresql and node
    $ pkg_add -r libxml2
    $ pkg_add -r libxslt
    $ pkg_add -r postgresql91-server
    $ pkg_add -r node

    # Installing Sqlite3
    # NOTE. The sqlite3 package contains the necessary development headers
    # NOTE. You have to pass the --with-sqlite3-dir compile flag to ensure the gem is installed correctly
    $ pkg_add -r sqlite3
    $ bundle config build.sqlite3 --with-sqlite3-dir=/usr/local/

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
[sqlite3]: http://www.sqlite.org/
[Nokogiri]: http://nokogiri.org/
[Taps]: http://rubygems.org/gems/taps
[ExecJS]: https://github.com/sstephenson/execjs
[NodeJS]: http://nodejs.org/