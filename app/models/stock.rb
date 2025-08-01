class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    FinnhubRuby.configure do |config|
      config.api_key['api_key'] = Rails.application.credentials[:finnhub_api_key]
    end

    finnhub_client = FinnhubRuby::DefaultApi.new
    new(ticker: ticker_symbol, name: finnhub_client.symbol_search(ticker_symbol)["result"][0]["description"], last_price: finnhub_client.quote(ticker_symbol)["c"])
  end
end
