
require 'tsm'

server = Tsm::Server.new(:gem)
database = QueryDb.new('format=detail')
db  = server.exec(database)
ap db.data[:format]

puts :END

