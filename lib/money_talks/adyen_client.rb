module MoneyTalks
  class AdyenClient

    attr_accessor :user, :password, :cse, :wsdl, :log_output

    # HACK =( Adyen's current published WSDL has no support for installments
    #PUBLISHED_TEST_URL = "https://pal-test.adyen.com/pal/servlet/Payment/v8?wsdl"
    #PUBLISHED_LIVE_URL = "https://pal-live.adyen.com/pal/servlet/Payment/v8?wsdl"

    def connection_handler
      @ws_client ||= Savon.client(
        basic_auth: [user, password],
        wsdl: wsdl,
        convert_request_keys_to: :lower_camelcase,
        pretty_print_xml: MoneyTalks::dev?,
        log: log_output
        )
    end

  end
end
