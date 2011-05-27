require 'nokogiri'
require 'nibbler'

module ScalableWorkforce

  class BatchList < Nibbler
    elements 'Batches/Batch/@BatchId' => :batches
    def [](arg)
      self.batches[arg]
    end
  end

  class BatchStatus < Nibbler
    element '@Name' => :name
    element '@StatusCode' => :status_code
    element '@Count' => :count, :with => lambda { |count| count.text.to_i }
  end

  class BatchStatusList < Nibbler
    element 'BatchStatus/@BatchId' => :id
    elements 'BatchStatus/Status' => :status, :with => BatchStatus
  end

  class Task < Nibbler

  end

  class TaskList < Nibbler
  end

end

