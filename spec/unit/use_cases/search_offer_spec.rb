require 'rails_helper'

describe SearchOffer do
  let(:valid_data) { {uid: "player1", pub0: "campaign2", page: "1"} }
  let(:http_request) { double }
  let(:offer_param) { double }
  let(:response_data) do 
    { "offers" =>
      [
        {
          "title"=>"Tap  Fish",
          "offer_id"=>13554,
          "teaser"=>"Download and START",
          "required_actions"=>"Download and START",
          "link"=>"http://iframe.sponsorpay.com/mbrowser?appid=157&lpid=11387&uid=player1",
          "offer_types"=>[{"offer_type_id"=>101, "readable"=>"Download"}, {"offer_type_id"=>112, "readable"=>"Free"}],
      "thumbnail"=>{
        "lowres"=>"http://cdn.sponsorpay.com/assets/1808/icon175x175-2_square_60.png", "hires"=>"http://cdn.sponsorpay.com/assets/1808/icon175x175-2_square_175.png"},
        "payout"=>90,
        "time_to_payout"=>{"amount"=>1800, "readable"=>"30 minutes"}
      }]
    }
  end

  subject { SearchOffer.new(http_request, {}) }

  before do 
    allow(http_request).to receive(:request).and_return(response_data)
    allow(OfferParam).to receive(:new).and_return(offer_param)
    allow(offer_param).to receive(:build)
  end

  describe "#execute" do 

    context "invariant checks" do 
      it "raises an ArgumentError if the data empty" do 
        expect { subject.execute({}) }.to raise_error ArgumentError
      end
 
      it "raises an ArgumentError if the data is nil" do 
        expect { subject.execute(nil) }.to raise_error ArgumentError
      end

      it "railse an ArgumentError if the data is invalid" do 
        invalid_data = valid_data.clone
        invalid_data.delete(:uid)
        expect { subject.execute(invalid_data) }.to raise_error ArgumentError
      end
    end

    after do 
      subject.execute(valid_data)
    end

    it "builds the offer params to request" do 
      expect(OfferParam).to receive(:new).with(valid_data, {})
    end

    it "makes an http request" do 
      expect(http_request).to receive(:request)
    end
    it "builds a set of offers" do 
      expect(Offer).to receive(:build).with(response_data)
    end


  end
end

