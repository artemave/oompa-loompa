require 'mongoid'

class Account
  include Mongoid::Document

  field :username
  has_many :tweets

  # todo test
  def minimum_acceptable_score
    username[/\d+$/].to_i
  end

  # todo test
  def source
    username[/^[^\d]+/]
  end
end
