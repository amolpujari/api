Sequel.migration do
  change do
    create_table :users do
      primary_key :id
      String :username
      String :email
      Integer :resource_id
    end
  end
end
