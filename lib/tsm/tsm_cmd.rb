require 'json'

class Tsm::Cmd

  attr_accessor :cmd, :data, :ts

  def initialize(cmd)
    @ts = Time.now.to_f
    @cmd = cmd
    @data = Hash.new
  end

end
