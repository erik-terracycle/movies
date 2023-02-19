# README

## Description

This is the application for fetching The Movie Database and provides a search for getting movies by a keyword.

## Requirements

This application currently works with:

* Rails 7.0.x
* Bundler 2.x
* PostgreSQL
* Redis 6.x

## Usage

1. Clone this repo for your locale machine
2. Bundle install
3. Create a .env file based on .env.sample and add your values to those keys
4. Create a pg DB and run migrations(db:migrate)
5. Make sure you run a redis server
6. Run the rails server(rails s) and sidekiq(bundle exec sidekiq)
7. Try out the application

## What is included?

#### These gems are added to the standard Rails stack

* Core
    * [pg][] – Pg is the Ruby interface to the PostgreSQL
    * [sidekiq][] – Redis-based job queue implementation for Active Job
    * [sidekiq-unique-jobs][] – This gem adds unique constraints to sidekiq jobs
* Configuration
    * [dotenv][] – for local configuration
    * [pry-byebug][] – adds step-by-step debugging to pry using byebug
* Style
    * [boostrap][] – Bootstrap 5 ruby gem for a nice UI
* Utilities
    * [httpclient][] – HTTP accessing library
    * [will_paginate][] – a pagination library that integrates with Ruby on Rails

[pg]:https://github.com/ged/ruby-pg
[sidekiq]:http://sidekiq.org
[sidekiq]:https://github.com/mhenrixon/sidekiq-unique-jobs
[dotenv]:https://github.com/bkeepers/dotenv
[pry-byebug]:https://github.com/deivid-rodriguez/pry-byebug
[boostrap]:https://getbootstrap.com/
[httpclient]:https://github.com/nahi/httpclient
[will_paginate]:https://github.com/mislav/will_paginate
