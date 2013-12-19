
module Locationer
  module LocationHelper
    def descriptors
      return [] unless self.alternatenames
      self.alternatenames.split(",")
    end
  end
end