class HttpRequest


  def request(params)
    http = HTTPClient.new
    #TODO move to configuration file
    url = "http://api.sponsorpay.com/feed/v1/offers.json?"
    url.concat(params)
    response = http.get(url)
    JSON.parse(response.content)
  end

end
