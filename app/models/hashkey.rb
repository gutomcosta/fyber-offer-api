require 'digest/sha1'

class Hashkey

  def initialize(params)
    @params  = params
  end

  def get
    sha1 = Digest::SHA1.hexdigest(@params)
    sha1.downcase
  end
end