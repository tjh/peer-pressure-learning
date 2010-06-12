task :cron do
  
  # Blogs to load
  sources = [
    'http://feeds.feedburner.com/timharvey',
    'http://feeds2.feedburner.com/mileszs'
  ]
  
  # Fragment of the category name allowed (all others skipped)
  category_fragment_allowed = "peer pressure"
  
  # Fragment of the title name allowed (all others skipped)
  title_fragment_allowed = "PPL:"
  
  require 'rubygems'
  require 'mongo_mapper'
  require 'feed_tools'
  
  %w{
  connect
  models
  feed_tools_unicode_patch
  }.each { |f| load File.join(File.dirname(__FILE__), 'lib', "#{f}.rb") }
  
  
  # While we can be more clever later, we'll just reload all
  # the posts every time this runs
  Post.delete_all
  
  # -----------------------------------------
  # ARG! I *hate* character encoding garbage
  # -----------------------------------------
  # Prepare to convert FeedTools default ISO encoding to UTF-8
  ic = Iconv.new('ISO-8859-1//IGNORE', 'UTF-8')
  
  sources.each do |source|
    rss = FeedTools::Feed.open("#{source}?format=xml")
    rss.items.each do |item|
      # Filter based on category
      # (combine the categories, if there are more than one, into a single string)
      # next unless item.categories.collect { |category| category.term }.join(",").downcase.include?(category_fragment_allowed)
      
      # Filter based on title
      # next unless item.title.include? title_fragment_allowed
      
      # -----------------------------------------
      # Debugging
      # -----------------------------------------
      # puts "-------------------------------------"
      # puts item.inspect
      # puts item.title
      # puts item.summary
      # puts item.time
      
      # This still doesn't seem to work...the "//IGNORE" rips 
      # the characters out that it can't decode
      begin
        body = ic.iconv(item.summary)
      rescue
        puts "ERROR: #{$!}"
        body = item.summary
      end
      
      # Truncate length
      body = body[0..1_024] + "..." unless body.length < 1024
      
      begin
        Post.create!(:title => item.title, :link => item.link, :body => body, :posted_at => item.time)
      rescue
        puts "There was a problem adding post '#{item.title}' to Mongo"
      end
    end
  end
end
