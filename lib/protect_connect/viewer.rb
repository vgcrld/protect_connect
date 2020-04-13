
require 'sinatra'
require 'awesome_print'
require 'json'
require 'haml'
require 'protect_connect'

module ProtectConnect

  class Viewer < Sinatra::Base

    configure do
      set :root, File.dirname(__FILE__)
      set :title, "Spectrum Protect Connect"
      set :static, true
      enable :corss_origin
    end
    
    get '/servers' do
      $server.keys.to_json
    end

    get '/settings' do
      haml :settings
    end

    before do
      response.headers['Access-Control-Allow-Origin'] = '*'
    end

    get '/' do
      haml :doc
    end

    get '/control/:instance/:command' do
      instance=params[:instance].to_sym
      command=params[:command].to_sym
      $server[instance].send(command)
    end

    get '/query/:instance/:query' do
      instance=params[:instance]
      query=params[:query]
      if $server[instance].nil?
        return ["#{instance} is unavailable."].to_json
      end
      data = $server[instance].exec(query)
      data.to_json
    end

  end

end
