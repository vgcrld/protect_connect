module Tsm; module ServerCommand

  class Base

    attr_accessor :cmd, :data

    def initialize
      @cmd = make_cmd
      @data = Hash.new
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
