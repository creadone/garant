module Garant
  class MaxRetriesExceeded < StandardError
    def initialize(msg = "The hash-function has reached the limit of generating unique hashes")
      super(msg)
    end
  end

  class MissingHashValue < StandardError
    def initialize(msg = "The hash-function return nil instead value")
      super(msg)
    end
  end
end