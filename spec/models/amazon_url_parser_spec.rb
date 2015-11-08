require "spec_helper"
require "app/models/amazon_url_parser"

describe AmazonUrlParser do
  describe "#item_id" do
    context "with different urls" do
      it "extracts the item id" do
        urls.each do |url|
          parser = AmazonUrlParser.new(url[:url])

          expect(parser.item_id).to eq(url[:id])
        end
      end
    end
  end

  def urls
    [
      {
        url: "http://www.amazon.com/dp/0131471392/ref=wl_it_dp_o_pC_S_ttl",
        id: "0131471392",
      },
      {
        url:"http://www.amazon.com/gp/product/B004UJ0U0C?colid=Q4FSQPNF7G2W",
        id: "B004UJ0U0C",
      },
      {
        url: "www.amazon.com/gp/product/B004UJ0U0C?colid=Q4FSQPNF7G2W",
        id: "B004UJ0U0C",
      },
      {
        url: "http://www.amazon.com/Super-Mario-Maker-Nintendo-Wii-U/dp/B00KWFCSB2/ref=sr_1_1?ie=UTF8&qid=1447017691&sr=8-1&keywords=mario",
        id: "B00KWFCSB2",
      },
    ]
  end
end
