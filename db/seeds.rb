15.times do |index|
  Order.create(address: "some fine address #{index}",
               price: (rand * 10).to_i * index,
               state: (rand * 10).to_i.even? ? 'pending' : 'delivered')
end
