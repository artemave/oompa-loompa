require 'mongoid'

class Tweet
  include Mongoid::Document

  field :link_url
end
