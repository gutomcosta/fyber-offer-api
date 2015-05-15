class OffersController < ApplicationController
  def index
  end

  def show
  end

  def search
    @form = OfferSearchForm.new(params[:offers])
    if @form.valid? 
      begin
        use_case = SearchOffer.build(load_offer_api_config, offer_url)
        @offers = use_case.execute({uid: @form.uid, pub0: @form.pub0, page: @form.page})
        respond_to do |format|
          format.js {}
          format.json { render json: @offers, status: :created }
        end
      rescue InvalidResponseToOfferAPI => e
        @form.errors[:signature] = "is invalid!"
        respond_to do |format|
          format.js
        end
        
      end
    else
      respond_to do |format|
        format.js {}
        format.json { render json: @offers, status: :created }
      end
    end
  end

  private 

  def load_offer_api_config
    {
      appid: Rails.application.config.offer_appid,
      format: Rails.application.config.offer_format,
      device_id: Rails.application.config.offer_device_id,
      locale: Rails.application.config.offer_locale,
      ip: Rails.application.config.offer_ip,
      offer_types: Rails.application.config.offer_offer_types,
      timestamp: Time.now.to_i,
      api_key: Rails.application.config.offer_api_key
    }
  end

  def offer_url
    Rails.application.config.offer_url
  end
end
