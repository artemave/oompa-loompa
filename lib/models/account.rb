require 'mongoid'

class Account
  include Mongoid::Document

  field :username
  has_many :tweets

  def minimum_acceptable_score
    username[/\d+$/].to_i
  end

  def source
    username[/^[^\d]+/]
  end
end
