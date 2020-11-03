require 'sinatra'
require 'faraday'
require 'json'
require 'net/http'
require 'rest-client'
require 'rest-client'
require './fibonacciAPI'

class SinatraApp < Sinatra::Base
    @table = {}
    @saved = false
    
    get "/" do
        erb :fibonacci
    end

    post "/generate-table" do
        puts "123"
        data = JSON.parse(request.body.read, symbolize_names: true)
        puts "Post WTf #{ data.to_json }"
        address = 'http://localhost:3001'
        route = '/fibonacci'
        
        resp = Faraday.get(address + route, data, {'Accept' => 'application/json'})
        puts "resp: #{resp.to_json}"

        result = ''
        if resp.status == 200 
            @table = 'resp.body.multiplicationTable'
            result = resp.body
        else
            result = 'Error'
        end

        result
    end
end