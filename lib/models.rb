class Post
 include MongoMapper::Document
 
 key :link, String
 key :title, String
 key :body, String
 timestamps!
end
