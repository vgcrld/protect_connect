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

    $ bundle install --path .

Or install it yourself as:

    $ gem install project_connect

## Usage

Create a server by creating a new `ProjectConnect::Server` object and pointing it to a dsm.sys stanza name. This requires that the `dsmadmc` executable be available on the system. `:gem` is a valid `dsm.sys` stanza name.

```ruby
serv = ProtectConnect::Server.new(:gem)
out = serv.exec('q db')
puts out.data
```

## View

You can also use the web view to get data out of a TSM instance. 

`bundle exec proect_view`

Browse to http://localhost:8080

## Tableau Web Data Connector

The web data connector can be found at [TSM Tableau WDC](http://localhost:8080/protect_summary.html). This can really only be accessed from tablaue. It will throw an error if called directly.

Note: right now this is only configured to speak to a specific TSM instance. It's hard coded in to find a dsm.sys stanza called "gem". 
