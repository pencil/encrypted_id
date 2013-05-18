# encrypted_id [![Build Status](https://secure.travis-ci.org/pencil/encrypted_id.png)](http://travis-ci.org/pencil/encrypted_id)

Sometimes you don't want your users to see the actual ID of your database entries. This gem allows you to "automagically" encrpyt the ID.

encrypted_id turns a URL like this:

    http://www.example.com/users/15

into something like this:

    http://www.example.com/users/1e8644f924812bec506b116ff14368c8

encrypted_id uses AES-256 (CBC) with a configurable key (per model) to do so.

## Installation

Add the gem to your [`Gemfile`](http://gembundler.com/):

    gem 'encrypted_id'

Run `bundler`:

    bundle install

## Usage

In your model, add the following line:

    class User < ActiveRecord::Base
      encrypted_id key: '5gA6lgr5g3GOg7EOQ1caYQ'
    end

Replace the "key" with a random value (should be different for every model).

## Contributing to encrypted_id

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012-2013 Nils Caspar. See LICENSE.txt for
further details.
