require 'rails_helper'

describe HttpRequest do
  let(:request_params) {"appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b83&format=json&ip=109.235.143.113&locale=de&offer_types=112&page=1&pub0=campaign2&timestamp=1431659105&uid=player1&hashkey=7a2b1604c03d46eec1ecd4a686787b75dd693c4d"}
  let(:http) { double }
  let(:response) { double }
  let(:content) do
    "{\"code\":\" OK\",\"message\":\"OK\",\"count\":1,\"pages\":1,\"information\":{\"app_name\":\"SP Test App\",\"appid\":157,\"virtual_currency\":\"Coins\",\"country\":\" US\",\"language\":\" EN\",\"support_url\":\"http://iframe.sponsorpay.com/mobile/DE/157/my_offers\"},\"offers\":[{\"title\":\"Tap  Fish\",\"offer_id\":13554,\"teaser\":\"Download and START\",\"required_actions\":\"Download and START\",\"link\":\"http://iframe.sponsorpay.com/mbrowser?appid=157\\u0026lpid=11387\\u0026uid=player1\",\"offer_types\":[{\"offer_type_id\":101,\"readable\":\"Download\"},{\"offer_type_id\":112,\"readable\":\"Free\"}],\"thumbnail\":{\"lowres\":\"http://cdn.sponsorpay.com/assets/1808/icon175x175-2_square_60.png\",\"hires\":\"http://cdn.sponsorpay.com/assets/1808/icon175x175-2_square_175.png\"},\"payout\":90,\"time_to_payout\":{\"amount\":1800,\"readable\":\"30 minutes\"}}]}"
  end
  subject { HttpRequest.new }

  before do 
    allow(HTTPClient).to receive(:new).and_return(http)
    allow(http).to receive(:get).and_return(response)
    allow(response).to receive(:content).and_return(content)
  end

  describe "API" do 
    it { should respond_to :request}
  end

  after do 
    subject.request(request_params)
  end

  describe "#request" do 
    it "execute the http request " do 
      url = "http://api.sponsorpay.com/feed/v1/offers.json?".concat(request_params)
      expect(http).to receive(:get).with(url)
    end

    it "returns a hash representation" do 
      expect(subject.request(request_params)).to include("code", "message", "count")
    end 
  end
end
