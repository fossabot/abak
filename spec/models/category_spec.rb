# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe Category, :type => :model do

    it "validates the name and makes sure it's not empty" do

        category = Category.new(name: '')
        category.valid?
        expect(category.errors[:name]).to_not be_empty
    
    end

end
