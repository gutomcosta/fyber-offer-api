class SearchOffer

  def self.build(api_config, offer_url)
    SearchOffer.new(HttpRequest.new(api_config.clone, offer_url), api_config.clone)
  end

  def initialize(http_request, api_config)
    @http_request   = http_request
    @api_config     = api_config
  end

  def execute(data)
    raise ArgumentError, "missing search data" unless data_exists?(data) && is_valid?(data)
    param    = OfferParam.new(data, @api_config)
    response = @http_request.request(param.build)
    Offer.build(response)
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