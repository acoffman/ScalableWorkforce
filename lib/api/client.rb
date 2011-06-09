require 'api/models'
require 'addressable/uri'
require 'addressable/template'
require 'net/http'
require 'net/https'

module ScalableWorkforce

  class ScalableWorkforceClient


    def initialize(params, environment = :sandbox)
      @credentials = params
      @accessKey = {:accessKey => @credentials[:access_key]}
      url = "#{BASE_URL[environment]}#{MAIN_URL}"
      BatchRequestUrl = Addressable::Template.new "#{url}batches"
      BatchStatusUrl = Addressable::Template.new  "#{url}batches/{BATCHID}/stats"
      BatchTasksUrl = Addressable::Template.new  "#{url}batches/{BATCHID}/tasks"
      WorkflowInputsUrl = Addressable::Template.new  "#{url}inputs"
      WorkflowTasksUrl = Addressable::Template.new  "#{url}tasks"
      WorkflowTaskUrl = Addressable::Template.new  "#{url}tasks/{TASKID}"
    end

    def import_batch(batch)
      url = BatchRequestUrl.expand @credentials
      parse_response(url, @accessKey, BatchResult, :post, batch.to_xml)
    end

    def get_batches
      url = BatchRequestUrl.expand @credentials
      parse_response(url, @accessKey, BatchList)
    end

    def get_batch_status(batchid)
      url = BatchStatusUrl.expand({:BATCHID => batchid}.merge(@credentials))
      parse_response(url, @accessKey, BatchStatusList)
    end

    def get_batch_tasks(batchid, status = nil)
      params = @accessKey.dup
      params[:STATUSCODE] = status unless status.nil?
      url = BatchTasksUrl.expand({:BATCHID => batchid}.merge(@credentials))
      parse_response(url, params, TaskList)
    end

    def get_workflow_inputs
      url = WorkflowInputsUrl.expand @credentials
      parse_response(url, @accessKey, RequiredInputs)
    end

    def get_tasks(task_list)
      url = WorkflowTasksUrl.expand @credentials
      parse_response(url, @accessKey, TaskList, :post, task_list)
    end

    def get_task(taskid)
      url = WorkflowTaskUrl.expand({:TASKID => taskid}.merge(@credentials))
      parse_response(url, @accessKey, Task)
    end

    def get_request(url)
      resp = Net::HTTP.start(url.host, url.port) { |http| http.get url.request_uri, 'User-agent' => 'SWF ruby client' }
      if Net::HTTPSuccess === resp
        resp.body
      else
        resp.error!
      end
    end

    def post_request(url,data)
      @headers ||= { 'Content-Type' => "text/xml; encoding='utf-8'",
                     'User-agent' => 'SWF ruby client' }
      resp = Net::HTTP.start(url.host, url.port, opt = {:use_ssl => true}) { |http| http.post(url.request_uri, data, @headers) }
      if Net::HTTPSuccess === resp
        resp.body
      else
        resp.error!
      end
    end

    def parse_response(url,params, parser = nil, method = :get, data = nil)
      url.query_values = params
      if method == :get
        resp = get_request url
      else
        resp = post_request url, data
      end
      parser ? parser.parse(body) : body
    end

  end

end
