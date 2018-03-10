require 'logger'

module Tsm;

  PROMPT = /(?<product>Protect|TSM): (?<server>\w+)>/

  DSMADMC = %w[
    dsmadmc
    -se=gem
    -id=admin
    -pa=admin
    -display=list
    -dataonly=yes
    -alwaysprompt
    -newlineafterprompt
  ].join(" ")

  LOG = Logger.new(STDOUT)

end
    
