require 'rails_helper'

RSpec.describe OffersController, type: :controller do

  describe "GET search" do 
    let(:params) { {"uid" => "player1", "pub0" => "campaign2", "page" => "1"} }


    context "about the validation" do 
      let(:form) { double(params) }
      let(:use_case) { double }
      
      before do 
        allow(OfferSearchForm).to receive(:new).and_return(form)
        allow(SearchOffer).to receive(:new).and_return(use_case)
        allow(form).to receive(:valid?)
        allow(use_case).to receive(:execute)
      end

      after do 
        get :search, :offers => {"uid" => "player1", "pub0" => "campaign2", "page" => "1"}
      end

      it "creates a form to validate the params" do 
        expect(OfferSearchForm).to receive(:new)
      end

      it "validates the params" do 
        expect(form).to receive(:valid?)
      end

      context "when validation is ok" do
        before do 
          allow(form).to receive(:valid?).and_return(true)
        end

        it "executes the use case with form data" do 
          expect(use_case).to receive(:execute).with(uid: "player1", pub0: "campaign2", page: "1")
        end
      end

      context "when validation fail" do 
        before do 
          allow(form).to receive(:valid?).and_return(false)
          get :search, :offers => {"uid" => "player1", "pub0" => "campaign2", "page" => "1"}
        end

        it "redirect to the index" do 
          expect(response).to redirect_to(action: :index)
        end
      end
    end
  end

end
