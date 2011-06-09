module Ksyusha
  # Models needed for drop baox
  class User
    require 'bcrypt'
    include Mongoid::Document
    field :username, type: String
    field :password, type: Hash
    field :email, type String
    embed_many :files
    embed_many :buckets

    def self.find_by_email(email)
      @user = User.where(email: email)
    end

    def password
      @password ||= Password.new(password_hash)
    end

    def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end

    def create
      @user = User.new(params[:user])
      @user.password = params[:password]
      @user.save!
    end

    def login
      @user = User.find_by_email(param[:emails])
      if @user.password == params[:password]
        give_token
      else
        return false
      end
    end

    def forgot_password
      @user = User.find_by_email(params[:email])
      random_password = Array.new(10).map { (65 + rand(58)).char }.join
      @user.password = random_password
      @user.save!
      Mailer.create_add_deliver_password_change(@user, random_password)
    end

  end
end
