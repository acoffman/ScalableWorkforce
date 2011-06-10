module ScalableWorkforce 

  #a task is a list of batchinputs
  class BatchRequest
    @tasks = []
    
    def initialize(tasks)
      @tasks = tasks
    end

    def to_xml
      xml = Builder::XmlMarkup.new
      xml.BatchRequest do 
        @tasks.each do |task|
          xml.Task do
            xml.Inputs do
              task.inputs.each do |input|
                xml.Input(:Name => input.name) do
                  input.values.each do |value|
                    xml.Value(value)
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  class TaskInput
    @inputs = []
    def initialize(inputs)
      @inputs = inputs
    end

    attr_accessor :inputs
  end
  
  class BatchInput
    def initialize(vals)
     @name = vals[:name]
     @values = vals[:values]
    end

    attr_accessor :name, :values
  end

end
