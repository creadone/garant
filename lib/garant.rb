require "set"
require "bloomer"
require "bloomer/msgpackable"
require "garant/config"
require "garant/errors"

module Garant
  class << self
    def safe(&block)
      retries = 0
      hashed_value = nil

      while true do
        hashed_value = block.call
        raise MissingHashedValue.new if hashed_value.nil?
        raise MaxRetriesExceeded.new if config.max_retries <= retries
        if config.storage.include?(hashed_value)
          retries += 1
        else
          config.storage.add(hashed_value)
          return hashed_value
        end
      end

    end
  end
end