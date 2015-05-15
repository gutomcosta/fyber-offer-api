class OffersController < ApplicationController
  def index
  end

  def show
  end

  def search
    form = OfferSearchForm.new(params[:offers])
    if form.valid? 
      begin
        use_case = SearchOffer.build
        @offers = use_case.execute({uid: form.uid, pub0: form.pub0, page: form.page})
        respond_to do |format|
          format.js {}
          format.json { render json: @offers, status: :created }
        end
      rescue InvalidResponseToOfferAPI => e
        render :json => {:errors => "Invalid Signature!"}
      end
    else
      redirect_to root_url
    end
  end
end
