require 'json'
require 'csv'

class ProtectConnect::Cmd

  attr_accessor :name

  attr_reader :data, :ts, :cmd

  def initialize(cmd,name=nil)
    @ts = Time.now.to_f
    @cmd = cmd
    @data = nil
    @name = make_name(cmd,name)
  end

  def data=(raw)
    @data = clean(raw)
  end

  def to_array_of_hashes
    data = to_h
    ret = Array.new(data.keys.length, Hash.new)
    data.keys.each do |head|
      data.values.first.each_index do |i|
        ret[i][head] = data[head][i] 
      end
    end
    return ret
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
      head.strip! unless head.nil?
      val.strip! unless val.nil?
      ret[head] ||= []
      ret[head] << val
    end
    return ret
  end

  def to_csv_table
    cmddata = self.to_h
    header = cmddata.keys
    data = cmddata.values
    start = data.shift
    zipped = start.zip(*data)
    rows = zipped.map{ |o| CSV::Row.new( header, o ) }
    table = CSV::Table.new(rows)
    return table
  end

  private

  def make_name(cmd,name)
    if name.nil?
      cmd.split(" ",3)[0..1].join("_").downcase
    else
      name
    end
  end

  def clean(raw)
    ret = raw.lines.map(&:chomp)
      .grep_v("")
      .grep_v(ProtectConnect::PROMPT)
    return ret
  end


end
