def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  # Consult README for inputs and outputs
  i = 0

  while i < collection.size do
    item_hash = collection[i]

    if (item_hash[:item] === name)
      return item_hash
    end
    i += 1
  end
  return nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  updated_cart = []
    i = 0

      while i < cart.size do
        item = cart[i][:item]
        item_hash = find_item_by_name_in_collection(item, updated_cart)

          if item_hash
          cart[i][:count] += 1
          else
            cart[i][:count] = 1
            updated_cart << cart[i]
          end
    i +=1
      end

  updated_cart
end


def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  update_cart = []

    while i < cart.size do
      item = cart[i][:item]
      coupon_item = find_item_by_name_in_collection(item, coupons)

        if coupon_item
            cart[i][:count] = (cart[i][:count] - coupon_item[:num])

            update_cart << cart[i]
            update_cart << {:item => "#{coupon_item[:item]} W/COUPON",
                        :price => coupon_item[:cost]/coupon_item[:num].round(2),
                        :clearance => cart[i][:clearance],
                        :count => (coupon_item[:num])}

        else
            update_cart << cart[i]
        end
      i+= 1
    end

update_cart
end


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  update_cart = []

  while i < cart.size do
      item = cart[i]

      if item[:clearance]
          new_price = (item[:price] * 0.8).round(2)
          cart[i][:price] = new_price

          update_cart << cart[i]

      else
         update_cart<< cart[i]
      end
  i += 1
  end

update_cart

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

itemized_cart = consolidate_cart(cart)
itemized_cart_w_coupons = apply_coupons(itemized_cart, coupons)
final_cart = apply_clearance(itemized_cart_w_coupons)

total = 0
 i = 0
   while i < final_cart.size do
       grocery_item = final_cart[i]
       grocery_price = grocery_item[:price]
       item_count = grocery_item[:count]

      total += grocery_price * item_count
   i += 1
   end

 total.round(2)

    if total > 100
      total = total * 0.9
    end

  total.round(2)
end
