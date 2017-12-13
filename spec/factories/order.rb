FactoryBot.define do
  factory :order do
    address 'Some random address'
    price 100

    trait :delivered do
      state 'delivered'
    end

    trait :pending do
      state 'pending'
    end
  end
end
