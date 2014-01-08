module MoneyTalks
  class SoapObjectBuilder

    attr_reader :soap_model
    delegate :serialize, to: :soap_model

    def initialize(model, &block)
      @model, @soap_model = model, SoapModel.new
      block.call(self)
    end

    def default_nodes(*attributes)
      attributes.each do |att|
        @soap_model.add_nested_member(att, @model.send(att))
      end
    end

    def node(name, &block)
      @soap_model.add_member(name)
      block.call(@soap_model.send(name))
    end

  end
end
