require 'rails_helper'

RSpec.describe OffersController, type: :controller do

  describe "GET search" do 
    let(:params) { {"uid" => "player1", "pub0" => "campaign2", "page" => "1"} }


    context "about the validation" do 
      let(:form) { double }
      before do 
        allow(OfferSearchForm).to receive(:new).with(params).and_return(form)
      end

      it "creates a form to validate the params" do 
        expect(OfferSearchForm).to receive(:new).with(params)
        get :search, :offers => {"uid" => "player1", "pub0" => "campaign2", "page" => "1"}
      end

      it "validates the params" do 
        expect(form).to receive(:valid?)
      end
    end
  end

end
