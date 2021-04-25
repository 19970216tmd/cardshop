FactoryBot.define do
  factory :order do
    order_id { '99' }
    user_id { '99' }
    card_id { '1' }
    buysell_flug { '1' }
    price { '200' }
    orderdate {}
    out_flug { '0' }
    delete_flug { '0' }
    out_user_id { '2' }
    shipment_flug { '0' }
    created_at { '' }
    updated_at { '' }
  end
end
