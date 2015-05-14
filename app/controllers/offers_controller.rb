class OffersController < ApplicationController
  def index
  end

  def show
  end

  def search
    form = OfferSearchForm.new(params[:offers])
    form.valid?
    render :nothing => true
  end
end
