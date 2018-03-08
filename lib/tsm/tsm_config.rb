require 'logger'

module Tsm;

  DSMADMC = %w[
    dsmadmc
    -se=gem
    -id=admin
    -pa=admin
    -display=list
    -dataonly=yes
    -alwaysprompt
    -NEWLINEAFTERPrompt
  ].join(" ")

  LOG = Logger.new(STDOUT)

  CMDS = %w[ 
    QueryDb
    QueryLog
    QueryLibrary
    QueryDrive
    QueryNode
    QueryDomain
    QueryPolicy
    QueryMgmt
    QueryCopy
  ]
 
end
    
