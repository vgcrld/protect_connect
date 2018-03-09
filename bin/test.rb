
require 'tsm'
require 'awesome_print'

cmd = Tsm::Cmd.new('q db f=d')

ap cmd
exit

# Create the Server
server = Tsm::Server.new(:gem)

ap server.exec('q db')
