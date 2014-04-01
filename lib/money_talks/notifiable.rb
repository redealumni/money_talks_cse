module MoneyTalks
  module Notifiable
    
    def self.included(klass)
      klass.extend(HookMethods)
    end

    def notify(event)
      exec_obj = self.class.registered_hook
      if exec_obj.kind_of?(Symbol) || exec_obj.kind_of?(String)
        self.send(exec_obj, event)
      elsif exec_obj.kind_of?(Proc)
        exec_obj.call(event)
      end
    end
    
  end
end
