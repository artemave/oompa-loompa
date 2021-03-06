require 'mongoid'
require_relative 'tweet'

class Account
  include Mongoid::Document

  field :username
  field :access_token
  field :access_secret
  embeds_many :tweets

  def minimum_acceptable_score
    username[/\d+$/].to_i
  end

  def source
    username[/^[^\d]+/]
  end
end
