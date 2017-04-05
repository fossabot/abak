# -*- encoding : utf-8 -*-
class AddAncestryToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :ancestry, :string
  end
end
