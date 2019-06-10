# Project Connect

This is an example GEM for a few different technologies. Spectrum Protect, Sinatra and Tableau Web Data Connector.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'protect_connect'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install project_connect

## Usage

Create a server by creating a new `ProjectConnect::Server` object and pointing it to a dsm.sys stanza name. This requires that the `dsmadmc` executable be available on the system.

`serv = ProjectConnect::Server.new(:stanza)`

Submit commands to it:

`res = serv.exec("q db f=d")`

A ProtectConnect::Cmd is returned:

`res.cmd`
`res.data`
`res.to_json`
