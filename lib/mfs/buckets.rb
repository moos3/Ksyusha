module Ksyusha
  class bucket
    field :name, type: String
    field :hash, type: Hash
    embeds_in :User
    
    def self.getName(user, bucket)
      require 'Digest'
      salt = "5FE6889F563673DD1B9BA218635628C885201EAB4FB35F053D8079C8070D9B6B649782746223CF6530438DE77C827EB3"
      hash = Digest::MD5.hexdigest(user+bucket+salt)
      return hash
    end
    
    def self.new(user, bucket)
      bucket_hash = self.getName(user,bucket)
      db = Mongo::Conection.db.new(bucket_hash)
      self.name = bucket
      self.hash = bucket_hash
    end
end