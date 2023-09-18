class PaymentsController < ApplicationController

  def place_order
    @property = Property.find_by(id: params[:id])
  end

  def subscription
    require "uri"
    require "json"
    require "net/http"

    url = URI("https://api.razorpay.com/v1/payment_links")
    time = (Time.now + 15.minute).to_i

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request["Authorization"] = ENV['BASE']
    request.body = JSON.dump({
      "amount": params[:amount].to_i*100,
      "currency": "INR",
      "accept_partial": false,
      "expire_by": 2094512165,
      "reference_id": "order#" + SecureRandom.hex(8),
      "description": "Payment for subsciption",
      "customer": {
        "name": current_user.profile.name,
        "contact": current_user.profile.mobile_number,
        "email": current_user.profile.email
      },
      "notify": {
        "sms": true,
        "email": true
      },
      "reminder_enable": true,
      "notes": {
        "policy_name": "Subscription"
      },
      "callback_url":  "#{ENV['HOST']}/success?type='#{params["type"]}'&limit='#{params["limit"].to_i}&amount=#{params["amount"].to_i}",
      "callback_method": "get"
    })
    response = https.request(request)
    @url = JSON.parse(response.read_body);
    redirect_to "/loader?url='#{@url["short_url"]}'"
  end

  def checkout
    require "uri"
    require "json"
    require "net/http"

    url = URI("https://api.razorpay.com/v1/payment_links")
    time = (Time.now + 15.minute).to_i

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request["Authorization"] = ENV['BASE']
    request.body = JSON.dump({
      "amount": params[:data][:total_price].to_i*100,
      "currency": "INR",
      "accept_partial": false,
      "expire_by": 2094512165,
      "reference_id": "order#" + SecureRandom.hex(8),
      "description": "Payment for policy no #23456",
      "customer": {
        "name": current_user.profile.name,
        "contact": current_user.profile.mobile_number,
        "email": current_user.profile.email
      },
      "notify": {
        "sms": true,
        "email": true
      },
      "reminder_enable": true,
      "notes": {
        "policy_name": "Jeevan Bima"
      },
      "callback_url":  "#{ENV['HOST']}/success?price=#{params["data"]["price"]}&property_name=#{params["data"]["property_name"]}&gst=#{params["data"]["gst"]}",
      "callback_method": "get"
    })
    response = https.request(request)
    @url = JSON.parse(response.read_body);
    redirect_to "/loader?url='#{@url["short_url"]}'"
  end

  def success
    require "uri"
    require "net/http"

    url = URI("https://api.razorpay.com/v1/payments/#{params[:razorpay_payment_id]}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = ENV['BASE']

    response = https.request(request)
    @payment = JSON.parse(response.read_body)
    if @payment["notes"]["policy_name"] == "Subscription"
      subscriptions = SubPlan.new
      subscriptions.sub_type = params["type"].gsub("'", '')
      subscriptions.limit = params["limit"].gsub("'",'').to_i
      subscriptions.amount = params["amount"].gsub("'",'').to_i
      subscriptions.user_id = current_user.id
      subscriptions.save
    end
    @order = Order.new
    if @payment["notes"]["policy_name"] == "Subscription"
      @order.order_type = "subscription"
    else
      @order.order_type = "nonsubscription"
    end
    @order.product_amount = params[:price]
    @order.product_name = params[:property_name]
    @order.gst = params[:gst]
    @order.user_id = current_user.id
    @order.order_id = @payment["order_id"]
    @order.amount = @payment["amount"]/100
    @order.status = @payment["status"]
    @order.payment_method = @payment["method"]
    @order.order_email = @payment["email"]
    @order.order_mobile = @payment["contact"]
    @order.time_at = Time.at(@payment["created_at"])
    if @payment["method"] == "upi"
      @order.upi_id = @payment["upi"]["vpa"] 
      @order.upi_transaction_id = @payment["acquirer_data"]["upi_transaction_id"]
    end
    @order.payment_id = @payment["id"]
    @order.save
  end

  def loader_payment
    
  end

  def order_view
    @order = Order.find_by(id: params[:id])
  end

end
