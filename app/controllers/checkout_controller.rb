class CheckoutController < ApplicationController

  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
                                                  payment_method_types: ["card"],
                                                  line_items: [{
                                                                 price_data: {
                                                                   product_data: {
                                                                     name: product.name },
                                                                   unit_amount: product.price,
                                                                   currency: "usd" },
                                                                 quantity: 1
                                                               }],
                                                  mode: 'payment',
                                                  success_url: root_url,
                                                  cancel_url: root_url,
                                                })
    redirect_to @session.url, allow_other_host: true
  end
end
