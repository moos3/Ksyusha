module Kysusha
  class files
    include Mongoid::Document
    field :name, type: String
    field :path, type: String
    field :grid_id, type: String
    field :metadata, type: Array
    field :chunk_size, type: String
    field :content_type, type: String
    field :revision, type: Integer
    field :uploaded_at, type: Time
    embeds_in User
    
    # Return List of files
    def self.fetch(user,bucket,filename)
        bucket_name = Bucket.getName(user,bucket)
        db = Mongo::Connection.db('buckets').collection(bucket_name)
        list = files.where(grid_id: bucket_name)
    end
    
    # Handle file uploads from user to a bucket
    def self.upload(user,bucket,filename,data)
      bucket_name = Bucket.getName(user,bucket)
      db = Mongo::Connection.new.db('files')
      grid = Mongo::Grid.new(db)
      extname = File.extname(filename)[1..-1]
      id = grid.put(data[:tempfile].read,
              :name => filename,
              :content_type => Mime::Type.lookup_by_extension(extname),
              :chunk_szie => 100 * 1024,
              :metadata => {'description' => decription, 'uploaded_at' => Time.now},
              :revision => 1,
              :uploaded_at => Time.now,
              :path => bucket + '/' + filename,
              :safe => true,
              :grid_id => Bucket.getName(user,bucket)
            )
    end
    
    #delete file from gridfs from given users bucket
    def self.delete(user,bucket,filename)
      bucket_name = Bucket.getName(user,bucket)
      db = Mongo::Connection.new.db('buckets').collection(bucket_name)
      grid = Mongo::Grid.new(db)
      _id = files.where(name: filename)
      grid.delete(_id)
    end
    
    def self.delete_bucket(user,bucket)
      bucket_hash = Bucket.getName(user,bucket)
      db = Mongo::Connection.new.db('buckets')
      db.collection.drop(bucket_hash)
    end
    
  end
end