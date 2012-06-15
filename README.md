TeuxDeux (unofficial API)
=========================
This library acts as a client for the [unofficial TeuxDeux API][apiwiki].

With it you can do all the things the webinterface can do:

* fetch your todos
* create new todos
* update your todos
* delete your todos

See the [API documentation][apiwiki] for more information about the returnend data.

Build Status: ![Travis CI Build Status](https://secure.travis-ci.org/badboy/teuxdeux.png)

Examples
========

### Create new client

    client = TeuxDeux::Client.new :login => "mail", :password => "secret"

### Get user data

    client.user
    => <#Hashie::Rash email="mail" id=42 login="name" time_zone="Berlin" utc_offset=60>

### Get todos

    client.todos
    => [<#Hashie::Rash do_on="2011-05-26" done=false id=10601581 position=0 todo="create awesome teuxdeux client" updated_at=1306353624 user_id=42>, ...]

### Get "someday" todos

    client.someday
    => [<#Hashie::Rash do_on="1989-12-01" done=false id=10601582 position=0 todo="be awesome" updated_at=1298486839 user_id=42>, ...]

### Create todo item

    client.create_todo("get freaky!", "2011-06-01")
    => [<#Hashie::Rash do_on="2011-06-01" done=false id=10601583 position=0 todo="get freaky!" updated_at=1306360182 user_id=42>, ...]

### Update todo item

    client.update_todo(10601581, :done => true)
    => [<#Hashie::Rash do_on="2011-05-26" done=true id=10601581 position=0 todo="create awesome teuxdeux client" updated_at=1306360182 user_id=42>, ...]

### Delete todo item

    client.delete_todo(10601581)
    => true

Inspiration
===========

This TeuxDeux API client was developed as an reference implementation of the [unofficial TeuxDeux API][apiwiki].

The API documentation was possible thanks to [mislav][]'s [instagram][] docu and his post about how he did the reasearch.

The code is heavily inspired by the awesome [Octokit][], a ruby wrapper for the GitHub API.

Contribute
==========

If there are bugs or missing features, please let me know. I would like to accept pull-requests.

As this is just the API client, what we now need is some alternative interfaces. I definitely need a solution for my Android phone. I'm not sure if I should stick with a web app or if I should create a native app.

If you want to help with either of this or just have additional questions or another implementation, contact me.

[apiwiki]: https://github.com/badboy/teuxdeux/wiki/API
[mislav]: https://github.com/mislav
[instagram]: https://github.com/mislav/instagram/
[octokit]: https://github.com/pengwynn/octokit
