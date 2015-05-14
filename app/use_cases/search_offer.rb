class SearchOffer

  def initialize
  end

  def execute(data)
    raise ArgumentError, "missing search data" unless data_exists?(data) && is_valid?(data)
    
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