def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  index = 0
  while index < collection.length do
    if collection[index][:item] == name
      return collection[index]
    end
    index += 1
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  shop_cart = []
  index = 0
  while index < cart.length do
    shop_cart_item = find_item_by_name_in_collection(cart[index][:item], shop_cart)
    if shop_cart_item != nil
      shop_cart_item[:count] += 1
      else
      shop_cart_item = {
        :item => cart[index][:item],
        :price => cart[index][:price],
        :clearance => cart[index][:clearance],
        :count => 1
      }
    shop_cart << shop_cart_item
    end
    index += 1
  end
  shop_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  index = 0
  while index < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[index][:item], cart)
    couponed_item = "#{coupons[index][:item]} W/COUPON"
    coupon_cart_item = find_item_by_name_in_collection(couponed_item, cart)
    if cart_item && cart_item[:count] >= coupons[index][:num]
      if coupon_cart_item
        coupon_cart_item[:count] += coupons[index][:num]
        cart_item[:count] -= coupons[counter][:num]
    else
      coupon_cart_item = {
        :item => couponed_item,
        :price => coupons[index][:cost] / coupons[index][:num],
        :count => coupons[index][:num],
        :clearance => cart_item[:clearance]
      }
      cart << coupon_cart_item
      cart_item[:count] -= coupons[index][:num]
    end
  end
  index += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0
  while index < cart.length do
    if cart[index][:clearance]
      cart[index][:price] = (cart[index][:price] - (cart[index][:price] * 0.20)).round(2)
    end
    index += 1
  end
  
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  
  grand_total = 0
  index = 0 
  while index < final_cart.length do
    grand_total += final_cart[index][:price] * final_cart[index][:count]
    index += 1 
  end
    
  if grand_total > 100
    grand_total -= (grand_total * 0.1)
  end
  
  grand_total
end