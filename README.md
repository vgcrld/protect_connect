# Project Connect

This is an example GEM for a few different technologies. Spectrum Protect, Sinatra and Tableau Web Data Connector.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'protect_connect'
```

or 

```ruby
gem 'protect_connect', git: 'git@github.com:vgcrld/protect_connect.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install project_connect

## Usage

Create a server by creating a new `ProjectConnect::Server` object and pointing it to a dsm.sys stanza name. This requires that the `dsmadmc` executable be available on the system.

`serv = ProtectConnect::Server.new(:stanza)`

Submit commands to it:

`res = serv.exec("q db f=d")`

A ProtectConnect::Cmd is returned:

`res.cmd`
`res.data`
`res.to_json`

## View

You can also use the web view to get data out of a TSM instance. 

`bundle exec proect_viewer`

Note: right now this is only configured to speak to a specific TSM instance. It's hard coded in to find a dsm.sys stanza called "gem". 
