require 'mongoid'

class Tweet
  include Mongoid::Document

  field :link_url

  embedded_in :account
end
