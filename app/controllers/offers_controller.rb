class OffersController < ApplicationController
  def index
  end

  def show
  end

  def search
    form = OfferSearchForm.new(params[:offers])
    if form.valid? 
      use_case = SearchOffer.new({uid: form.uid, pub0: form.pub0, page: form.page})
      use_case.execute
    end
    render :nothing => true
  end
end
