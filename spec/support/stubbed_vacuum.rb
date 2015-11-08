class StubbedVacuum
  def initialize(details)
    @details = details
  end

  def associate_tag=(something)
    #noop
  end

  def item_lookup(query)
    VacuumResponse.new(@details)
  end
end

class VacuumResponse
  def initialize(details)
    @details = details
  end

  def to_h
    {"ItemLookupResponse"=>
     {"OperationRequest"=>
      {"HTTPHeaders"=>{"Header"=>{"Name"=>"UserAgent", "Value"=>"Jeff/1.5.1 (Language=Ruby; ares.local)"}},
       "RequestId"=>"a8279e28-02d2-4703-b4bc-669ab41f4d02",
       "Arguments"=>
      {"Argument"=>
       [
         {"Name"=>"AWSAccessKeyId", "Value"=>"AKIAINQWKZ76LYIIEWVQ"},
         {"Name"=>"Signature", "Value"=>"/MUlX8F8H8bsHQJmvzsy3XPiVEUwjmEyPV3W0tScT3Q="}]},
      "RequestProcessingTime"=>"0.0088050000000000"},
      "Items"=>
      {"Request"=>{"IsValid"=>"True", "ItemLookupRequest"=>{"IdType"=>"ASIN", "ItemId"=>"B004UJ0U0C", "ResponseGroup"=>"ItemAttributes", "VariationPage"=>"All"}},
       "Item"=>
      {"ASIN"=>"B004UJ0U0C",
       "ParentASIN"=>"B004UJ0TDU",
       "DetailPageURL"=> @details[:url],
       "ItemLinks"=>
      {"ItemLink"=>
       [{"Description"=>"All Offers", "URL"=>"http://www.amazon.com/gp/offer-listing/B004UJ0U0C%3FSubscriptionId%3DAKIAINQWKZ76LYIIEWVQ%26tag%3Dbestow-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3DB004UJ0U0C"}]},
      "ItemAttributes"=>
       {"Binding"=>"Kitchen",
        "Brand"=>"Simple Ecology",
        "Color"=>"Natural Cotton",
        "EAN"=>"0753182636542",
        "EANList"=>{"EANListElement"=>"0753182636542"},
        "Feature"=>
       ["BEWARE OF COUNTERFEIT OFFERS! Simple Ecology designs, manufactures and EXCLUSIVLY sell our products directly to consumers online, no wholesale middlemen. Any other online seller is not offering genuine new Simple Ecology product.",
        "Set of 6 - 2 each of Large, Medium & Small sizes.",
        "Sewn in EXTERIOR tare weight tag makes checkout credit easy.",
        "Excellent for storing produce in the refrigerator. A damp bag will help greens stay crisp for days.",
        "Made in India of first-grade 4 oz. Organic Cotton Muslin Fabric, certified according to Global Organic Textile Standards (GOTS) for Ecology & Social Responsibility."],
       "Label"=>"Simple Ecology",
       "ListPrice"=>{"Amount"=>"3050", "CurrencyCode"=>"USD", "FormattedPrice"=>"$#{@details[:price]}"},
       "Manufacturer"=>"Simple Ecology",
       "MPN"=>"8244",
       "PackageDimensions"=>
       {"Height"=>{"__content__"=>"90", "Units"=>"hundredths-inches"}, "Length"=>{"__content__"=>"1040", "Units"=>"hundredths-inches"}, "Weight"=>{"__content__"=>"20", "Units"=>"hundredths-pounds"}, "Width"=>{"__content__"=>"770", "Units"=>"hundredths-inches"}},
         "PartNumber"=>"8244",
         "ProductGroup"=>"Kitchen",
         "ProductTypeName"=>"HOME",
         "Publisher"=>"Simple Ecology",
         "Size"=>"Set of 6 (2 ea. of L, M, S)",
         "Studio"=>"Simple Ecology",
         "Title"=>@details[:name],
         "UPC"=>"753182636542",
         "UPCList"=>{"UPCListElement"=>"753182636542"}}}}}}
  end
end
