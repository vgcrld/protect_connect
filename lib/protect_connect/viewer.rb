
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

    get '/' do
      haml :doc
    end

    get '/query/:instance/:query' do
      instance=params[:instance].to_sym
      query=params[:query]
      data = $server[instance.to_sym].exec(query)
      data.to_json
    end

  end

end
