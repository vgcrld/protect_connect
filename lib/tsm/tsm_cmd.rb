require 'json'

module Tsm;

  CMDS = %w[ 
    QueryActlog
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
 
  class Cmd

    attr_accessor :cmd, :data

    def initialize(cmd)
      @cmd = cmd
      @data = Hash.new
    end

    def to_json
      @data[:format].to_json
    end

    private 

    def make_cmd(opts=[])
      cmd = self.class.to_s.split(/::/).last.
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("_", " ").
      downcase
      return ( cmd + " " + (opts.join(" ")))
    end

  end

end;
