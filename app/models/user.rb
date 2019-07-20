class User < Sequel::Model
	many_to_one :resource
end
