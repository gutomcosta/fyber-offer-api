class OffersController < ApplicationController
  def index
  end

  def show
  end

  def search
    form = OfferSearchForm.new(params[:offers])
    if form.valid? 
      use_case = SearchOffer.new()
      use_case.execute({uid: form.uid, pub0: form.pub0, page: form.page})
      render :nothing => true # just thinking about this...
    else
      redirect_to root_url
    end
  end
end
