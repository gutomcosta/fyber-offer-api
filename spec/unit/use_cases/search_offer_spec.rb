require 'rails_helper'

describe SearchOffer do
  let(:valid_data) { {uid: "player1", pub0: "campaign2", page: "1"} }
  let(:hashkey) { double }
  let(:hashkey_calculator) { double }
  let(:url) { double }
  let(:offer_url) { double }
  let(:response_data) { double }
  let(:http_request) { double }


  subject { SearchOffer.new(hashkey_calculator, offer_url, http_request) }

  before do 
    allow(hashkey_calculator).to receive(:calculate).and_return(hashkey)
    allow(offer_url).to receive(:build).and_return(url)
    allow(http_request).to receive(:request).and_return(response_data)
    allow(response_data).to receive(:offers).and_return([])
  end

  describe "#execute" do 

    context "invariant checks" do 
      it "raises an ArgumentError if the data empty" do 
        expect {
          subject.execute({})
        }.to raise_error ArgumentError
      end

      it "raises an ArgumentError if the data is nil" do 
        expect {
          subject.execute(nil)
        }.to raise_error ArgumentError
      end

      it "railse an ArgumentError if the data is invalid" do 
        invalid_data = valid_data.clone
        invalid_data.delete(:uid)
        expect {
          subject.execute(invalid_data)
        }.to raise_error ArgumentError
      end
    end

    after do 
      subject.execute(valid_data)
    end

    it "gets the hashkey calculated" do 
      expect(hashkey_calculator).to receive(:calculate).with(valid_data)
    end

    it "builds the URL to search offers" do 
      expect(offer_url).to receive(:build).with(valid_data, hashkey)
    end

    it "makes an http request" do 
      expect(http_request).to receive(:request).with(url)
    end
    it "builds a set of offers" do 
      expect(Offer).to receive(:build).with([])
    end


  end
end

