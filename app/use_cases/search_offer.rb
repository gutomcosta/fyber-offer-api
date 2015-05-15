class SearchOffer

  def initialize(http_request)
    @http_request   = http_request
  end

  def execute(data)
    raise ArgumentError, "missing search data" unless data_exists?(data) && is_valid?(data)
    param    = OfferParam.new(data)
    response = @http_request.request(param.build)
    Offer.build(response.offers)
  end

  private 

  def data_exists?(data)
    (! data.nil?) &&  (! data.empty?)
  end
  
  def is_valid?(data)
    data.has_key?(:uid) &&
    data.has_key?(:pub0) &&
    data.has_key?(:page)
  end

  
end