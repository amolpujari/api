class Resource < Sequel::Model
  order_by :name
  permit :name
  one_to_many :users
  includables :users
end
