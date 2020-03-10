def find_item_by_name_in_collection(name, collection)

  i = 0 
  while i < collection.length do 
    if collection[i][:item] === name
      result = collection[i]
    end 
    i += 1
    end
  result 
end

def consolidate_cart(cart)
  i = 0
  consolidated = []

  while i < cart.count do
    item_name = cart[i][:item]
    item_exists = find_item_by_name_in_collection(item_name, consolidated)
    if item_exists
      item_exists[:count] += 1
    else
      cart[i][:count] = 1
      consolidated << cart[i]
    end
    i += 1
  end

  consolidated
end


def apply_coupons(cart, coupons)

  
  i = 0
  
  while i < coupons.length do
    coupon = coupons[i]
    item_name = coupon[:item]
    discounted_item = find_item_by_name_in_collection(item_name, cart)
    coupon_count = coupon[:num]
    coupon_price = coupon[:cost]
    item_exists = !!discounted_item
    
    if item_exists and discounted_item[:count] >= coupon_count
      discount_price = ( coupon_price / coupon_count).round(2)
      discounted_cart = {
        :item => "#{item_name} W/COUPON",
        :price => discount_price,
        :count => coupon_count
      }
      discounted_cart[:clearance] = discounted_item[:clearance]
      discounted_item[:count] -= coupon[:num]
      cart << discounted_cart
    end
    
    i += 1
  end 
  
  cart
end


def apply_clearance(cart)
  i = 0
  while i < cart.length do 
    if cart[i][:clearance] == true
      cart[i][:price] *= 0.80
    end
    i += 1
  end 
  cart
end

def checkout(cart, coupons)
  compact_cart = consolidate_cart(cart)
  discounted = apply_coupons(compact_cart, coupons)
  final_cart = apply_clearance(discounted)
  
  total = 0
  i = 0 
  while i < final_cart.length do 
    cart_item = final_cart[i]
    total_item_price = cart_item[:price] * cart_item[:count]
    total += total_item_price
    i += 1 
  end
  
  if total > 100 
    total *= 0.90
  end 
  total = total.round(2)
end

