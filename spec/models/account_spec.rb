require_relative '../../lib/models/account'
require_relative '../spec_helper'

describe Account do
  subject { Account.new username: 'HN150' }

  its(:source) { should == 'HN' }
  its(:minimum_acceptable_score) { should == 150 }
end
