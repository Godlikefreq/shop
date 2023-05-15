class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV["STRIPE_WEBHOOKS_KEY"].to_s
      )
    rescue JSON::ParserError => e
      puts "Signature error"
      puts e
      return
    end

    case event.type
    when "checkout.session.completed"
      session = event.data.object
      @product = Product.find_by(price: session.amount_total)
      @product.increment!(:sales_count)
    end

    render json: { message: "success" }
  end
end
