class RemoveTypeAndSchoolFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :school, :string
  	remove_column :users, :type, :string
  end
end
