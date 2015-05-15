class OfferParam

  attr_reader :request_params

  def initialize(params)
    @request_params  = params
    build_request_params
  end

  def build
    params             = concatenate(sorted_params)
    params_to_hashkey  = with_api_key(params.clone)
    hashkey            = Hashkey.new(params_to_hashkey)
    value = with_hashkey(params,hashkey.get)
    value
  end

  private

  def build_request_params
    #TODO it should be moved to a config file
    @api_key         = "b07a12df7d52e6c118e5d47d3f9e60135b109a1f"

    basic_params = {
      appid: "157",
      format: "json",
      device_id: "2b6f0cc904d137be2e1730235f5664094b83",
      locale: "de",
      ip: "109.235.143.113",
      offer_types: "112",
      timestamp: Time.now.to_i
    }
    @request_params.merge!(basic_params)
  end

  def sorted_params
    Hash[@request_params.sort]
  end

  def concatenate(sorted_values)
    return "" if sorted_values.nil?
    sorted_values
    .map{|value| value.join("=")}
    .join("&")
  end

  def with_api_key(params)
    concat_with(params, @api_key)
  end

  def with_hashkey(params,hashkey_value)
    other = "hashkey=".concat(hashkey_value)
    concat_with(params,other)
  end

  def concat_with(params,other)
    params
      .concat("&")
      .concat(other)
  end
end