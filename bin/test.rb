
require 'tsm'
require 'awesome_print'

# Create the Server
server = Tsm::Server.new


d = server.exec('q db')

ap d.data

`cat #{server.output.path}`

