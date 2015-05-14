require 'rails_helper'

describe SearchOffer do
  let(:valid_data) { {uid: "player1", pub0: "campaign2", page: "1"} }


  describe "#initialize" do 

    it "raises an ArgumentError if the data empty" do 
      expect {
        SearchOffer.new({})
      }.to raise_error ArgumentError
    end

    it "raises an ArgumentError if the data is nil" do 
      expect {
        SearchOffer.new(nil)
      }.to raise_error ArgumentError
    end

    it "railse an ArgumentError if the data is invalid" do 
      valid_data.delete(:uid)
      invalid_data = valid_data
      expect {
        SearchOffer.new(invalid_data)
      }.to raise_error ArgumentError

    end
  end
end

