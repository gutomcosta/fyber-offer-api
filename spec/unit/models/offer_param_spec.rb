require 'rails_helper'

describe OfferParam do
  let(:valid_data) { {uid: "player1", pub0: "campaign2", page: "1"} }
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
      uid:"player1"
    }
  end

  subject { OfferParam.new(valid_data)}

  before do
    allow(valid_data).to receive(:sort).and_return([])
    allow(Hash).to receive(:[]).and_return({})
  end

  describe "API" do 
    it { should respond_to :build }
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
      #Humn, private method tests? maybe put this in something like ParamsConcatenator?
      expected = "appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b83&format=json&ip=109.235.143.113&locale=de&offer_types=112&page=1&pub0=campaign2&uid=player1"
      expect(subject.send(:concatenate, sorted_params)).to eq(expected)                 
    end


  end


end
