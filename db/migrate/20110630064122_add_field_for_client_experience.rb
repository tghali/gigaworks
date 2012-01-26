class AddFieldForClientExperience < ActiveRecord::Migration
  def self.up
    add_column :talents, :client_experiene_from_month, :string
    add_column :talents, :client_experiene_from_year, :integer
    add_column :talents, :client_experiene_to_month, :string
    add_column :talents, :client_experiene_to_year, :integer

  end

  def self.down
    remove_column :talents, :client_experiene_from_month, :string
    remove_column :talents, :client_experiene_from_year, :integer
    remove_column :talents, :client_experiene_to_month, :string
    remove_column :talents, :client_experiene_to_year, :integer
  end
end
