require 'open3'
require 'tempfile'
require 'fileutils'

include Open3

module ProtectConnect

  class Server

    attr_reader :output, :uuid, :name, :dsmadmc, :user, :password, :stanza, :log

    def initialize(config)
      @log = Logger.new(STDOUT)
      @stanza = config['stanza']
      @user = config['user']
      @password = config['password']
      @dsmadmc = dsmadmc?(@stanza)
      unless @dsmadmc.nil?
        @prompt = init
        @uuid = get_uuid
        @name = get_name
      end
    end

    # Inital login should return the prompt from TSM
    def init
      @output = outfile
      @stdin = connect(@output)
      trash = get_buffered
      return trash
    end
    alias close init

    def quit
      close_all
    end

    def reinit
      close_all
      init
    end

    def exec(cmd,name=nil)
      tsmcmd = ProtectConnect::Cmd.new(cmd,name=name)
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

    def get_uuid
      self.exec('select MACHINE_GUID from status')
        .to_h.values.first.first.delete(".")
    end

    def get_name
      self.exec('select SERVER_NAME from status')
        .to_h.values.first.first.delete(".")
    end


    def outfile
      output = Tempfile.new(['tsmoutput-','.tmp'])
      output.sync = true
      return output
    end

    def connect(outfile)
      stdin, stdout, stderr, pid = popen3("#{@dsmadmc} > #{outfile.path}")
      return stdin
    end

    def close_all
      @output.unlink
      @stdin.close
    end

    def get_buffered
      data = ""
      cycles = 0
      count = 0
      until (match=data.match(ProtectConnect::PROMPT))
        data += @output.read_nonblock(@output.size-@output.pos)
        cycles += 1
        if (cycles%10000) == 0
          count += 1
          raise "Connect failed." if count == 1000
        end
      end
      return data
    end

    def dsmadmc?(stanza)
      dsmadmc = [ ProtectConnect::DSMADMC, "-se=#{self.stanza} -id=#{self.user} -pa=#{self.password}" ].join(" ")
      rc = `#{dsmadmc} quit`
      if $?.exitstatus > 0
        @log.warn "Can't connect to dsmadmc: #{rc}" if $?.exitstatus > 0
        return nil
      end
      return dsmadmc
    end

  end
end
