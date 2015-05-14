class OfferSearchForm 
  include ActiveAttr::Model

  attribute :uid
  attribute :pub0
  attribute :page

  validates_presence_of :uid, :pub0, :page

end