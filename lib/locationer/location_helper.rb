
module Locationer
  module LocationHelper
    def descriptors
      return [] unless self.alternatenames
      self.alternatenames.split(",")
    end

    def factory_girl_formatter
      format = ->(_val, col) do 
        if col == "alternatenames"
          list = _val.split(",")[0..3].compact.join(",")
          "\"#{list}\""
        elsif _val.is_a? String
          "\"#{_val}\""
        else
          _val
        end
      end

      self.attributes.each do |col,val|
        puts "#{col} #{format.call(val,col)}" if val && col != "id"
      end

      nil
    end
  end
end