module MoneyTalks
  module SavonSerializationSupport

    def to_symbolized_hash
      Hash[instance_variables.map { |n| [n[1..-1].to_sym, instance_variable_get(n)] }]
    end

  end
end
