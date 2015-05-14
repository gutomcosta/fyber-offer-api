class SearchOffer

  def initialize(haskey_calculator, offer_url, http_request)
    @calculator     = haskey_calculator
    @offer_url      = offer_url
    @http_request   = http_request
  end

  def execute(data)
    raise ArgumentError, "missing search data" unless data_exists?(data) && is_valid?(data)
    hashkey  = @calculator.calculate(data)
    url      = @offer_url.build(data, hashkey)
    response = @http_request.request(url)
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