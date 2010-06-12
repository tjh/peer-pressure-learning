require 'rubygems'
require 'sinatra'
require 'haml'      # must be loaded after sinatra
require 'sass'

get '/' do
  haml :index
end
