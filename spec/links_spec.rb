require_relative 'spec_helper'
require_relative '../lib/links.rb'
require_relative '../lib/link_sources/proggit.rb'
require_relative '../lib/link_sources/hn.rb'

describe Links do
  it "fetches all links" do
    link1, link2, link3 = double, double, double

    Hn.should_receive(:fetch).and_return([link1,link2])
    Proggit.should_receive(:fetch).and_return([link3])

    links = Links.fetch
    links.should =~ [link1, link2, link3]
  end
end
