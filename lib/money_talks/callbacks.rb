module MoneyTalks
  module Callbacks
    
    CALLBACKS = %w(on_authorization on_cancellation on_capture on_refund)

    def on_authorization_error(&block)
      block.call(
    end

    on_authorization_error do |resp|
          
    end
    
    def self.included(klass)
      CALLBACKS.each do |callback|
        %w(error success).each do |m|
          method_name = "#{callback}_#{m}".to_sym
          MoneyTalks::Payment.class_eval %Q"
            def #{method_name}(resp)
              #{klass.method(method_name).call(resp) if klass.respond_to? method_name}
            end
          "
        end
      end
    end

  end
end
