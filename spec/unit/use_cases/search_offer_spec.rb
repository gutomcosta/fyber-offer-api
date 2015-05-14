require 'rails_helper'

describe SearchOffer do
  let(:valid_data) { {uid: "player1", pub0: "campaign2", page: "1"} }

  subject { SearchOffer.new }

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
        valid_data.delete(:uid)
        invalid_data = valid_data
        expect {
          subject.execute(invalid_data)
        }.to raise_error ArgumentError
      end
    end

    it "gets the hashkey calculated"
    it "builds the URL to search offers"
    it "makes an http request" 
    it "builds a set of offers"


  end
end

