%w{models.rb client.rb batchrequest.rb}.each do |file|
  require File.dirname(__FILE__) +"/lib/" + file
end

module ScalableWorkforce

  VERSION = '0.1.0'

  BASE_URL = {
    :sandbox => 'https://api.sandbox.scalableworkforce.com/xml/',
    :production => 'https://api.scalableworkforce.com/xml/'
  }
  
  MAIN_URL = "{CLIENTHANDLE}/workflows/{WORKFLOWHANDLE}/"

end
