require 'nokogiri'
require 'builder'
require 'addressable/uri'
require 'addressable/template'
require 'net/http'
require 'net/https'
require 'nibbler'

%w{models.rb client.rb batchrequest.rb}.each do |file|
  require_relative "api/" + file
end

module ScalableWorkforce

  VERSION = '0.1.0'

  BASE_URL = {
    :sandbox => 'https://api.sandbox.scalableworkforce.com/xml/',
    :production => 'https://api.scalableworkforce.com/xml/'
  }
  
  MAIN_URL = "{CLIENTHANDLE}/workflows/{WORKFLOWHANDLE}/"

end
