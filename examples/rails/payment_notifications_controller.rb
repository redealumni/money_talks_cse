class PaymentNotificationController < ApplicationController
  def create
    p = Payment.find_by_psp_reference(params[:psp_reference])
    p.notify(params[:post_msg])
  end
end
