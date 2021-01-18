module Garant
  class << self
    attr_accessor :config
  end

  def self.setup
    self.config ||= Config.new
    yield config
  end

  class Config
    attr_accessor :error_probability
    attr_accessor :expected_size
    attr_accessor :max_retries

    attr_accessor :dump_load_path
    attr_accessor :dump_save_path

    attr_accessor :storage_type
    attr_accessor :storage

    def initialize
      @error_probability = 0.01
      @expected_size     = 1_000_000
      @storage_type      = :bloom
      @max_retries       = 15
      @dump_save_load    = nil
      @dump_load_path    = nil

      init_storage
    end

    private
      def init_storage
        if @storage_type == :bloom
          @storage = if @dump_load_path
            Bloomer.from_msgpack(@dump_load_path)
          else
            Bloomer.new(@expected_size, @error_probability)
          end
        elsif @storage_type == :set
          @storage = Set.new
        end
        return nil
      end
  end
end