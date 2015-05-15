require 'rails_helper'

describe Hashkey do
  let(:concatenated) {"appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b83&format=json&ip=109.235.143.113&locale=de&offer_types=112&page=1&pub0=campaign2&uid=player1&b07a12df7d52e6c118e5d47d3f9e60135b109a1f"}
  let(:sha1) { double }

  subject { Hashkey.new(concatenated)}

  describe "API" do 
    it { should respond_to :get }
  end

  before do 
    allow(sha1).to receive(:downcase)
    allow(Digest::SHA1).to receive(:hexdigest).and_return(sha1)
  end

  after do 
    subject.get
  end

  describe "#concatenate" do 
    it "generates the SHA1 basend on params" do 
      expect(Digest::SHA1).to receive(:hexdigest).with(concatenated).and_return(sha1)
    end

    it "sets the hashkey to lowercase" do 
      expect(sha1).to receive(:downcase)      
    end
  end
end