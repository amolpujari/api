Sequel.migration do
  change do
    create_table(:resources) do
      primary_key :id, :type=>"int(10) unsigned"
      column :name, "varchar(255)"
      column :created_at, "datetime"
      column :updated_at, "datetime"
    end
    
    create_table(:schema_migrations) do
      column :filename, "varchar(255)", :null=>false
      
      primary_key [:filename]
    end
  end
end
Sequel.migration do
  change do
    self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20180702053119_create_resources.rb')"
  end
end
