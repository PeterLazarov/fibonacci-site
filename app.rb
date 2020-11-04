require 'sinatra'
require 'faraday'
require 'json'
require "addressable/uri"

class SinatraApp < Sinatra::Base    
    get "/" do
        erb :fibonacci
    end

    get "/fibonacci" do
        data = request.params
        puts data
        
        resp = Faraday.get('http://localhost:3001/fibonacci', data,  {'Accept' => 'application/json'})

        result = ''
        if resp.status == 200 
            result = resp.body
        else
            result = 'Error'
        end

        result
    end

    post "/fibonacci" do
        data = JSON.parse(request.body.read, symbolize_names: true)
        
        resp = Faraday.post('http://localhost:3001/fibonacci', data,  {'Accept' => 'application/json'})

        result = ''
        if resp.status == 200 
            result = resp.body
        else
            result = 'Error'
        end

        result
    end
end