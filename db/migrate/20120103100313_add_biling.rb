class AddBiling < ActiveRecord::Migration
  def self.up
   add_column :clientcredit_details,:fname,:string
   add_column :clientcredit_details,:sname,:string
   add_column :clientcredit_details,:billing_add,:string
   add_column :clientcredit_details,:city,:string
   add_column :clientcredit_details,:region,:string
   add_column :clientcredit_details,:country,:string
  end

  def self.down
   remove_column :clientcredit_details,:fname
   remove_column :clientcredit_details,:sname
   remove_column :clientcredit_details,:billing_add
   remove_column :clientcredit_details,:city
   remove_column :clientcredit_details,:region
   remove_column :clientcredit_details,:country
  end
end
