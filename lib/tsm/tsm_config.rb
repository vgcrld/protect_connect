require 'logger'

module Tsm;

  PROMPT = /(?<product>Protect|tsm|TSM): (?<server>\w+)>/

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
    [ 'q status',        'status' ],
    [ 'q opt',           'options' ],
    [ 'q db f=d',        'database' ],
    [ 'q log f=d',       'log' ],
    [ 'q vol f=d',       'volume' ],
    [ 'q pro',           'process' ],
    [ 'q sess f=d',      'session' ],
    [ 'q mount f=d',     'mount' ],
    [ 'q drive f=d',     'drive' ],
    [ 'q path f=d',      'path' ],
    [ 'q node f=d',      'node' ],
    [ 'q stg f=d',       'stgpool' ],
    [ 'q do f=d',        'domain' ],
    [ 'q pol f=d',       'policy' ],
    [ 'q mg f=d',        'mgmtclass' ],
    [ 'q copy f=d',      'backup_copygrp' ],
    [ 'q copy t=a f=d',  'archive_copygrp' ],
    [ 'q occ',           'occupancy' ],
    [ 'q file f=d',      'filespace' ],
    [ 'q ev * * f=d',    'client_event' ],
    [ 'q ev * t=a f=d',  'admin_event' ],
  ]


end

