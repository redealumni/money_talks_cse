module MoneyTalks
  module Serializable
    
    def to_hash

      obj ={};self.instance_variables.each do |v|
        obj.store(v.to_s.gsub("@","").intern, self.instance_variable_get(v))
      end
      obj

    end
    
  end
end
