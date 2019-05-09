require 'logger'

module Tsm;

  PROMPT = /(?<product>Protect|TSM): (?<server>\w+)>/

  DSMADMC = %w[
    dsmadmc
    -id=admin
    -pa=admin
    -display=list
    -dataonly=yes
    -alwaysprompt
    -newlineafterprompt
  ]

  LOG = Logger.new(STDOUT)

  # Commands to run each time
  COMMANDS = [ 
    'q status',
    'q opt',
    'q db f=d',
    'q log f=d',
    'q vol f=d',
    'q pro',
    'q sess f=d',
    'q mount f=d',
    'q drive f=d',
    'q path f=d',
    'q node f=d',
    'q stg f=d',
    'q do f=d',
    'q pol f=d',
    'q mg f=d',
    'q copy f=d',
    'q copy t=a f=d',
    'q occ',
    'q file f=d',
    'q ev * * f=d',
    'q ev * t=a f=d'
  ]


end
    
