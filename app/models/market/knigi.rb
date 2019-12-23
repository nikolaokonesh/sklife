module Market
  module Knigi
    def self.use_relative_model_naming?
      true
    end

    def self.table_name_prefix
      'market_knigi_'
    end
  end
end
