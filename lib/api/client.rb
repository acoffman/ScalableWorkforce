require 'api/models'
require 'addressable/uri'
require 'addressable/template'
require 'net/http'

module ScalableWorkforce

  class ScalableWorkforceClient


    def initialize(params, environment = :sandbox)
      @credentials = params
      url = "#{BASE_URL[environment]}#{MAIN_URL}"
      BatchRequest = Addressable::Template.new "#{url}batches"
      BatchStatus = Addressable::Template.new  "#{url}batches/{BATCHID}/stats"
      BatchTasks = Addressable::Template.new  "#{url}batches/{BATCHID}/tasks"
      WorkflowInputs = Addressable::Template.new  "#{url}inputs"
      WorkflowTasks = Addressable::Template.new  "#{url}tasks"
      WorkflowTask = Addressable::Template.new  "#{url}tasks/{TASKID}"
    end

    def get_request(url)
      resp = Net::HTTP.start(url.host, url.port) { |http| http.get url.request_uri, 'User-agent' => 'SWF ruby client' }
      if Net::HTTPSuccess === resp
        resp.body
      else
        resp.error!
      end
    end

    def post_request
    end

    def parse_response(url,params,parser = nil)
      url.query_values = params
      resp = get_request url
      parser ? parser.parse(body) : body
    end

  end

end
