require 'rails_helper'

describe OfferParam do
  let(:valid_data) { {uid: "player1", pub0: "campaign2", page: "1"} }
  let(:concatenated) {"appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b83&format=json&ip=109.235.143.113&locale=de&offer_types=112&page=1&pub0=campaign2&timestamp=1431659105&uid=player1"}
  let(:with_api_key) { concatenated.concat("&").concat("b07a12df7d52e6c118e5d47d3f9e60135b109a1f") }
  let(:sorted_params) do 
    {
      appid:"157",
      device_id:"2b6f0cc904d137be2e1730235f5664094b83",
      format:"json",
      ip:"109.235.143.113",
      locale:"de",
      offer_types:"112",
      page:"1",
      pub0:"campaign2",
      timestamp: "1431659105",
      uid:"player1",
    }
  end
  let(:api_config) do 
    {
      appid: "157",
      format: "json",
      device_id: "2b6f0cc904d137be2e1730235f5664094b83",
      locale: "de",
      ip: "109.235.143.113",
      offer_types: "112",
      timestamp: 1431659105,
      api_key: "b07a12df7d52e6c118e5d47d3f9e60135b109a1f"
    }
  end

  subject { OfferParam.new(valid_data, api_config)}


  describe "API" do 
    it { should respond_to :build }
  end

  before do 
    allow(Time).to receive(:now).and_return(1431659105)
  end

  describe "#initialize" do 
    it "creates a request params with a set of basic params and the receive params" do 
      expect(subject.request_params).to include(:uid, :pub0, :page)
      expect(subject.request_params).to include(:appid, :format, :device_id, :locale, :ip, :offer_types )
    end
  end

  after do 
    subject.build
  end

  describe "#build" do 
    it "order all params alphabetically" do 
      expect(valid_data).to receive :sort
      expect(Hash).to receive(:[])
    end

    it "concatenate all params" do 
      #Humn, private method test? maybe put this in something like ParamsConcatenator?
      expect(subject.send(:concatenate, sorted_params)).to eq(concatenated)                 
    end

    it "concatenates with api key" do 
      expect(subject.send(:with_api_key,concatenated)).to eq with_api_key
    end

    it "gets the hashkey" do 
      hashkey = double
      expect(Hashkey).to receive(:new).with(with_api_key).and_return(hashkey)
      expect(hashkey).to receive(:get).and_return("b07a12df7d52e6c118e5d47d3f9e60135b109a1f")
    end

    it "generates the request params with hashkey" do 
      hashkey = double
      allow(Hashkey).to receive(:new).and_return(hashkey)
      allow(hashkey).to receive(:get).and_return("7a2b1604c03d46eec1ecd4a686787b75dd693c4d")

      request_params = concatenated.concat("&hashkey=7a2b1604c03d46eec1ecd4a686787b75dd693c4d")
      expect(subject.build).to eq request_params  

    end
  end


end
