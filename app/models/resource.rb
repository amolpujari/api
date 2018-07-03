class Resource < Sequel::Model
  order_by :name
  permit :name
end
