require_relative 'spec_helper'
require_relative '../lib/links.rb'
require_relative '../lib/crawlers/r_programming.rb'
require_relative '../lib/crawlers/hn.rb'

describe Links do
  let(:link1) { double score: 10 }
  let(:link2) { double score: 20 }
  let(:link3) { double score: 30 }

  it "fetches all links" do
    expect(Hn).to receive(:fetch).and_return([link1,link2])
    expect(RProgramming).to receive(:fetch).and_return([link3])

    links = Links.fetch
    expect(links).to match_array([link1, link2, link3])
  end

  it "weeds out links without score" do
    allow(Hn).to receive(:fetch).and_return([link1,link2])
    allow(RProgramming).to receive(:fetch).and_return([link3])

    allow(link2).to receive(:score).and_return(nil)

    links = Links.fetch
    expect(links).to match_array([link1, link3])
  end
end
