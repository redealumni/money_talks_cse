module MoneyTalks

  class SoapModel < OpenStruct
    
    def add_member(attribute)
      new_ostruct_member attribute
      send("#{attribute}=", self.class.new)
    end
    
    def add_nested_member(attribute, value)
      new_ostruct_member attribute
      send("#{attribute}=", value)
    end

    def serialize
      Hash[self.each_pair.map do |k,v|
        if v.kind_of? SoapModel
          [k, v.to_h]
        else
          [k, v]
        end
      end]
    end

  end
end
