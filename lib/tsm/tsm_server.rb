require 'open3'
require 'tempfile'
require 'fileutils'

include Open3

module Tsm;

  class Server
    
    attr_reader :output

    def initialize
      dsmadmc?
      init
    end

    def init
      @output = outfile
      @stdin = connect(@output)
      trash = get_buffered
    end
    alias close init

    def quit
      close_all
    end

    def reinit
      close_all
      init
    end

    def exec(cmd)
      runcmd(cmd)
    end

    def save(file)
      begin
        FileUtils.cp(output.path,file)
      rescue
        puts "Unable to copy to #{file}."
        return
      end
      reinit
    end

    private 

    def outfile
      output = Tempfile.new(['tsmoutput-','.tmp'])
      output.sync = true
      return output
    end

    def connect(outfile)
      stdin, stdout, stderr, pid = popen3("#{Tsm::DSMADMC} > #{outfile.path}")
      return stdin
    end
    
    def close_all
      @output.unlink
      @stdin.close
    end
    
    def runcmd(cmd)
      tsmcmd = Tsm::Cmd.new(cmd)
      begin
        @stdin.puts(cmd)
      rescue
        puts "Failed, reconnecting."
        close_all
        init
        @stdin.puts(cmd)
      end
      tsmcmd.data = get_buffered
      return tsmcmd
    end
    
    def get_buffered
      data = ""
      cycles = 0
      count = 0
      until (match=data.match(Tsm::PROMPT))
        data += @output.read_nonblock(@output.size-@output.pos)
        cycles += 1
        if (cycles%10000) == 0
          count += 1
          raise "Connect failed." if count == 100
        end
      end
      return data
    end
    
    def dsmadmc?
      rc = `#{Tsm::DSMADMC} quit`
      raise "Can't connect to dsmadmc: #{rc}" if $?.exitstatus > 0
      return true
    end
    
  end
end
