class AmazonInformationFinder
  def initialize(raw_url)
    @raw_url = raw_url
  end

  def name
    amazon_response["ItemLookupResponse"]["Items"]["Item"]["ItemAttributes"]["Title"]
  rescue
  end

  def amount
    amazon_response["ItemLookupResponse"]["Items"]["Item"]["ItemAttributes"]["ListPrice"]["FormattedPrice"][1..-1]
  rescue
  end

  def url
    amazon_response["ItemLookupResponse"]["Items"]["Item"]["DetailPageURL"]
  rescue
  end

  private

  def amazon_response
    @amazon_response ||= lookup_amazon_information
  end

  def lookup_amazon_information
    request = Vacuum.new
    request.associate_tag = ENV["AMAZON_ASSOCIATE_TAG"]
    response = request.item_lookup(
      query: {"ItemId" => item_id, "ResponseGroup" => "ItemAttributes"}
    )
    response.to_h
  end

  def item_id
    @item_id ||= AmazonUrlParser.new(@raw_url).item_id
  end
end
