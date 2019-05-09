require 'json'

class Tsm::Cmd

  attr_accessor :cmd, :ts

  attr_reader :data

  def initialize(cmd)
    @ts = Time.now.to_f
    @cmd = cmd
    @data = nil
  end

  def data=(raw)
    @data = clean(raw)
  end

  def to_json
    self.to_h.to_json
  end

  def headers
    self.to_h.keys
  end
   
  def to_h
    ret = {}
    ccc = @data.map do |o| 
      head, val = o.split(":",2)
      head.strip!
      ret[head] ||= []
      ret[head] << val
    end
    return ret
  end

  private 

  def clean(raw)
    raw.lines.map(&:chomp)
      .grep_v("")
      .grep_v(/^Protect: .*\>/)
  end

end
