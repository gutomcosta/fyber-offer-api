class OfferParam

  attr_reader :request_params

  def initialize(params, api_config)
    @request_params  = params
    @api_config      = api_config
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
    @api_key = @api_config.delete(:api_key)
    @request_params.merge!(@api_config)
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