class Post
 include MongoMapper::Document
 
 key :link, String
 key :title, String
 key :body, String
 key :posted_at, Date
 timestamps!
end
