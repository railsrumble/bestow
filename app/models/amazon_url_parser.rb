class AmazonUrlParser
  def initialize(url)
    @url = url
  end

  def item_id
    raw_item_id.split("?")[0]
  end

  private

  attr_reader :url

  def dp_format?
    url.include?("/dp/")
  end

  def url_without_scheme
    @url_without_scheme ||= build_url_without_scheme
  end

  def build_url_without_scheme
    if url_has_scheme?
      split_url[2..-1]
    else
      split_url
    end
  end

  def split_url
    @split_url ||= url.split("/")
  end

  def url_has_scheme?
    url.start_with?("http")
  end

  def raw_item_id
    if url_without_scheme[-1].start_with?("ref")
      url_without_scheme[-2]
    else
      url_without_scheme[-1]
    end
  end
end
