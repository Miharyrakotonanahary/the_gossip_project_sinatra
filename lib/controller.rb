require 'gossip'
require 'csv'
class ApplicationController < Sinatra::Base
  get '/' do
    erb :index,locals: {gossips: Gossip.all}
  end
  
  get '/gossips/new/' do
    erb :new_gossip
  end

	post '/gossips/new/' do
  	Gossip.new(params["gossip_author"],params["gossip_content"]).save
  	redirect '/'
	end

 	get '/gossips/:num' do |id|
    erb :gossip, locals: {gossip: Gossip.find(id.to_i), comments: Gossip.read_comments(id.to_i)}
  	end

  	post '/gossips/:id' do |id|
    Gossip.add_comment(id, params["gossip_comment"])
    redirect "/gossips/#{id}"
  	end

  	get '/edit_gossip/:num' do |id|
    erb :edit_gossip
  	end

  	post '/edit_gossip/:num' do |id|
    Gossip.new(params["gossip_author"],params["gossip_content"]).edit(id.to_i)
    redirect '/'
  	end

end

	

