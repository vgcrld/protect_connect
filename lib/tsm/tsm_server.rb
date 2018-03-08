require 'awesome_print'
require 'open3'
require 'tempfile'

include Open3

module Tsm;

  class Server
    
    attr_reader :data

    def initialize(servername)
      @data = setup(servername)
      @delim = get_delim
      @data = Hash.new(false)
    end

    def setup(servername)
      Tsm::LOG.info "Connect to TSM Server Name: #{servername}"
      dsmadmc?
      connect
      return Hash.new(false)
    end

    def connect
      @output = Tempfile.new(['tsmoutput-','.tmp'])
      @output.sync = true
      @outs ||= []
      @outs << @output
      @stdin, @stdout, @stderr, @pid = popen3("#{Tsm::DSMADMC} > #{@output.path}")
    end
    
    def get_delim
      delim = nil
      while delim.nil? or delim.empty?
        delim = get_buffered('.*:.*>\n')
      end
      return delim
    end
    
    def close_all
      @stdin.close  unless @stdin.nil?
      @stdout.close unless @stdout.nil?
      @stderr.close unless @stderr.nil?
    end
    
    def exec(tsmcmd)
      cmd = tsmcmd.cmd
      ret = Hash.new
      begin
        @stdin.puts(cmd)
      rescue
        puts "Failed, reconnecting: #{fetch(@stderr)}"
        retry
      end
      data = get_buffered
      ret[:format] = format(data)
      ret[:raw] = data
      tsmcmd.data = ret
      return tsmcmd
    end
    
    def get_buffered(delim=@delim)
      data = ""
      cycles = 0
      count = 0
      until data.match /#{delim}$/
        data += @output.read_nonblock(@output.size-@output.pos)
        cycles += 1
        if (cycles%10000) == 0
          count += 1
          print "."
          raise "Can't seem to connect." if count == 10
        end
      end
      return data
    end
    
    def format(data,delim=@delim)
      data = data.gsub(delim,"").squeeze("\n")
      data.lines.map do |line|
        line.strip.squeeze(" ").split(": ",2)
      end
    end
    
    def reopen
      close_all
      connect
    end
    
    def dsmadmc?
      Tsm::LOG.debug "Connect: #{Tsm::DSMADMC}"
      rc = `#{Tsm::DSMADMC} quit`
      raise "Can't connect to dsmadmc: #{rc}" if $?.exitstatus > 0
      return true
    end
    
  end
end
