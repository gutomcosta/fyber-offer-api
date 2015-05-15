class Offer
  attr_reader :title, :thumbnail, :payout

  def self.build(data)
    return [] unless data.has_key?("offers")
    offers    = data["offers"]
    thumbnail = ""
    offers.map do |offer|
      thumbnail = offer["thumbnail"]["lowres"] if offer.has_key?("thumbnail")
      Offer.new(offer["title"],thumbnail, offer["payout"])
    end
  end

  def initialize(title, thumbnail, payout)
    @title      = title
    @thumbnail  = thumbnail
    @payout     = payout
  end
end