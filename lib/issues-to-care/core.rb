require 'rest-client'

module Bitpot
  # Core elements for Bitpot class
  class Core
    BITBUCKET_API = 'https://api.bitbucket.org/1.0'

    def initialize configuration = {}
      @configuration = configuration
    end

    private

    def resource
      RestClient::Resource.new "#{Bitpot::Core::BITBUCKET_API}/#{@configuration.username}/#{@configuration.password}", @configuration.username, @configuration.password
    end
  end
end
