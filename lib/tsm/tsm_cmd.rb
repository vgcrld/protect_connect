require 'json'

class Tsm::Cmd

  attr_accessor :cmd, :data

  def initialize(cmd)
    @cmd = cmd
    @data = Hash.new
  end

end
