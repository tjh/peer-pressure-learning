task :cron do
  require 'rubygems'
  require 'mongo_mapper'
  require 'feed_tools'
  
  %w{
  connect
  models
  }.each { |f| load File.join(File.dirname(__FILE__), 'lib', "#{f}.rb") }
  
  Post.delete_all
  
  rss = @feed = FeedTools::Feed.open('http://feeds.feedburner.com/timharvey')
  @feed.items.each do |item|
    next unless item.categories.collect { |category| category.term }.join(",").downcase.include?("peer pressure")
    
    Post.create!(:title => item.title, :link => item.link, :body => item.summary)
    
    # puts "================================="
    # puts item.title
    # puts item.link
    # puts item.summary
    # puts item.categories.collect { |category| category.term }.join(",")
    # puts "================================="
  end
end