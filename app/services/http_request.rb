class InvalidResponseToOfferAPI < RuntimeError
end

class HttpRequest

  def initialize(api_config,base_url)
    @api_config = api_config
    @base_url   = base_url
  end


  def request(params)
    http = HTTPClient.new
    @base_url.concat(params)
    response = http.get(@base_url)
    raise InvalidResponseToOfferAPI.new("[HttpRequest] - Invalid X-Sponsorpay-Response-Signature.") unless valid_response?(response)
    JSON.parse(response.content)
  end

  def valid_response?(response)
    api_key              = @api_config[:api_key]  
    signature            = response.headers["X-Sponsorpay-Response-Signature"]
    body                 = response.body.clone
    response_and_api_key = body.concat(api_key)
    hashkey = Hashkey.new(response_and_api_key)
    sha1    = hashkey.get
    sha1 == signature
  end

end
