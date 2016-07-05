require 'pry'

def consolidate_cart(cart)
  # code here
  consolidated_cart = {}

  cart.each do |item|
    item_name = item.keys[0]

    if consolidated_cart.keys.include?(item_name)
      consolidated_cart[item_name][:count] += 1
    else
      item_props = item[item_name]
      item_props[:count] = 1
      consolidated_cart[item_name] = item_props
    end
  end

  consolidated_cart
end

def apply_coupons(cart, coupons)
  # code here
  discounted_cart = cart

  coupons.each do |coupon|
    #binding.pry
    if discounted_cart.keys.include?(coupon[:item]) && (discounted_cart[coupon[:item]][:count] >= coupon[:num])

      discounted_item = "#{coupon[:item]} W/COUPON"

      discounted_cart[coupon[:item]][:count] -= coupon[:num]
      #binding.pry
      if discounted_cart.keys.include?(discounted_item)
        prev_count = discounted_cart[discounted_item][:count]
      else
        prev_count = 0
      end
      discounted_cart[discounted_item] = {price: coupon[:cost], clearance: discounted_cart[coupon[:item]][:clearance], count: prev_count + 1}
      #binding.pry
    end     
  end

  #binding.pry
  discounted_cart
end

def apply_clearance(cart)
  #binding.pry
  cart.collect do |item_name, item_props|
    if item_props[:clearance] == true
      item_props[:price] = (item_props[:price]*0.8).round(2)
    end
  end

  #binding.pry
  cart
  # code here
end

def checkout(cart, coupons)

  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupons)
  cart = apply_clearance(cart)

  cart_total = 0.0

  cart.each do |item_name, item_props|
    cart_total += item_props[:price]*item_props[:count]
  end

  if cart_total > 100.0
    cart_total = (cart_total*0.9).round(2)
  end

  cart_total
  #cart = 
  # code here
end
