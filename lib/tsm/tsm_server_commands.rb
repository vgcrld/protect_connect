require 'json'

module Tsm; module ServerCommand

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
 
  class Base

    attr_accessor :cmd, :data

    def initialize
      @cmd = make_cmd
      @data = Hash.new
    end

    def to_json
      @data[:format].to_json
    end

    private 

    def make_cmd
      self.class.to_s.split(/::/).last.
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("_", " ").
      downcase
    end

  end

  # Define Server Command Classes Dynamically.  See tsm_config.rb CMDS
  CMDS.each do |klass_name|
    klass = Class.new(Tsm::ServerCommand::Base) do
      define_method :cmd do
        make_cmd
      end
    end
    Object.const_set(klass_name, klass)
  end

end; end
