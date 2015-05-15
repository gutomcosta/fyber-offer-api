class InvalidResponseToOfferAPI < RuntimeError
end

class HttpRequest


  def request(params)
    http = HTTPClient.new
    #TODO move to configuration file
    url = "http://api.sponsorpay.com/feed/v1/offers.json?"
    url.concat(params)
    response = http.get(url)
    raise InvalidResponseToOfferAPI.new("[HttpRequest] - Invalid X-Sponsorpay-Response-Signature.") unless valid_response?(response)
    JSON.parse(response.content)
  end

  def valid_response?(response)
    api_key              = "b07a12df7d52e6c118e5d47d3f9e60135b109a1f"
    signature            = response.headers["X-Sponsorpay-Response-Signature"]
    body                 = response.body.clone
    response_and_api_key = body.concat(api_key)
    hashkey = Hashkey.new(response_and_api_key)
    sha1    = hashkey.get
    sha1 == signature
  end

end
