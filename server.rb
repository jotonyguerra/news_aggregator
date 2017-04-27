require 'sinatra'
require 'pry'
require 'sinatra/flash'
require 'csv'
enable :sessions

set :bind, '0.0.0.0'  # bind to all interfaces

get '/' do
  redirect '/articles'
end

get '/articles' do
  @articles = CSV.read('text.csv')
  erb :index
end

get '/articles/new' do
  erb :new
end

post '/articles/new' do

  @articles_title = params['title']
  @url = params['URL']
  @description = params['description']


  if @articles_title == ""
    flash[:error]="Invalid Title"
    redirect '/articles/new'
  elsif @url ==  ""
    flash[:error]="Invalid URL"
    redirect '/articles/new'
  elsif @description == ""
    flash[:error]="Invalid description"
    redirect '/articles/new'
  else
    CSV.open('text.csv', 'a') do |file|
      file << [@articles_title, @url, @description]
    end
    redirect '/articles'
  end
end
