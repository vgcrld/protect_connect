
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
    
    get '/settings' do
      haml :settings
    end

    before do
      response.headers['Access-Control-Allow-Origin'] = '*'
    end

    get '/summary' do
      data = $server.exec('select * from summary where start_time>=current_timestamp-(1)day')
      data.to_json
    end

    get '/nodes' do
      data = $server.exec('q node f=d')
      data.to_json
    end

    get '/status' do
      data = $server.exec('q status')
      data.to_json
    end

    get '/' do
      haml :doc
    end

  end

end
