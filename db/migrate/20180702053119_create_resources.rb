Sequel.migration do
  change do

    create_table :resources do
      Integer :id, type: "INT UNSIGNED NOT NULL AUTO_INCREMENT, PRIMARY KEY (id)"
      String :name
      DateTime :created_at
      DateTime :updated_at
    end

  end
end
