require 'rubygems'
require 'mongo_mapper'
require 'sinatra'
require 'haml'      # must be loaded after sinatra
require 'sass'

%w{
connect
models
}.each { |f| load File.join(File.dirname(__FILE__), 'lib', "#{f}.rb") }

get '/' do
  posts = Post.all :order => "posted_at DESC"
  haml :index, :locals => { :posts => posts }
end
