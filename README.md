# Tsm

TODO: This should be renamed to spectrum protect before it is released.

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/tsm`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tsm'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tsm

## Usage

Create a server:

`serv = Tsm::Server.new`

Submit commands to it:

`res = serv.exec("q db")`

A TsmCmd is returned:

`res.cmd`
`res.data`

# Other Tsm::Server Options

What file are we writing to:

`serv.output`

Re-create the output file to clear used space:

`serv.reinit`

Exit and cleanup:

`serv.quit`


