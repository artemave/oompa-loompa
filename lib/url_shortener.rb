require 'google/apis/urlshortener_v1'

class UrlShortener
  def self.shorten long_url
    service = Google::Apis::UrlshortenerV1::UrlshortenerService.new
    service.key = ENV.fetch "GOOGLE_API_KEY"
    service.user_ip = ENV.fetch "GOOGLE_ALLOWED_IP"

    url = Google::Apis::UrlshortenerV1::Url.new
    url.long_url = long_url
    short_url = begin
      res = service.insert_url(url)
      res.id
    rescue Google::Apis::ClientError => e
      # some urls e.g. https://youtu.be/p9nH2vZ2mNo?t=5m40s give this error
      #<Google::Apis::ClientError: invalid: Invalid Value>
      $logger.error e.inspect
      nil
    end
    short_url || long_url
  end
end
