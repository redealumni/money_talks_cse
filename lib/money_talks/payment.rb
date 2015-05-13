module MoneyTalks
  class Payment

    extend Savon::Model

    attr_accessor :merchant_account, :reference, :shopper_IP, :shopper_email, :shopper_reference, :fraud_offset,
      :select_brand, :authorization_code, :selected_brand, :shopper_statement, :selected_brand,
      :social_security_number, :delivery_date, :original_reference

    OPERATIONS = {
      authorise:        'payment_request',
      refund:           'modification_request',
      cancel_or_refund: 'modification_request'
    }

    complex_types = %w(amount installments billing_address shopper_name modification_amount card)

    complex_types.each do |struct_name|
      define_method struct_name do |&block|
        var = instance_variable_get("@#{struct_name}")
        instance_variable_set("@#{struct_name}", OpenStruct.new) if var.nil?
        block ? block.call(instance_variable_get("@#{struct_name}")) : instance_variable_get("@#{struct_name}")
      end
    end

    %(authorise refund cancel_or_refund).each do |method|
      define_method method do |args|
        response = client.connection_handler.call(method, message.data.serialize_as(OPERATIONS[method]))
        block_given? ? yield response : response
        rescue Savon::SOAPFault => error
          raise MoneyTalks::Error.new(error.message.match(/[0-9]{3}/).to_s)
      end
    end

    private

    def serialize_as(operation)
      {operation => Hash[self.instance_variables.map do |v|
        symbolized_key = v.to_s.gsub("@","").to_sym
        if self.instance_variable_get(v).kind_of? OpenStruct
          [symbolized_key, self.instance_variable_get(v).to_h]
        else
          [symbolized_key, self.instance_variable_get(v)]
        end
      end
      ]}
    end

    def client
      MoneyTalks::client
    end

  end
end
