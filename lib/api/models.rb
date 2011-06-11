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

  class IOSuper < Nibbler
    element '@Name' => :name
    elements 'Value' => :values
  end

  class Input < IOSuper
  end

  class Output < IOSuper
  end

  class Task < Nibbler
    element '@TaskId' => :id
    element '@Status' => :status
    elements 'Inputs' => :inputs, :with => Input
    elements 'Outputs' => :outputs, :with => Output
  end

  class TaskList < Nibbler
    elements '/Tasks/Task' => :tasks, :with => Task
    def [](arg)
      self.tasks[arg]
    end
  end

  class BatchResult < Nibbler
    element '@BatchId' => :id
    elements '/BatchResult/Task/@TaskId' => :tasks
  end

  class RequiredInputs < Nibbler
    elements 'Input' => :inputs, :with => Input
    def [](arg)
      self.inputs[arg]
    end
  end

end

