module MoneyTalks
  module Serializable

    def to_h
      Hash[self.instance_variables.map do |v|
        symbolized_key, var = v.to_s.gsub("@","").to_sym, self.instance_variable_get(v)
        if var.respond_to?(:to_h)
          [symbolized_key, var.send(:to_h)]
        else
          [symbolized_key, var]
        end
      end
      ]
    end

  end
end
