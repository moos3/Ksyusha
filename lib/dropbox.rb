require 'sinatra/base'
require 'recarpet'
require 'yaml'
require 'bcrypt'
require 'mongoid'
require 'mongomapper'

module Ksyusha
  class << self
    attr_accessor :homepage
  end
  
  def self.new
    App
  end
end

require_relative 'mfs/page_not_found'
require_relative 'mfs/user'
require_relative 'mfs/file'
require_relative 'mfs/app'