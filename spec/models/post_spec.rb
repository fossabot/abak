# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe Post, :type => :model do
  it "validates the name, preview, body and makes sure it's not empty" do
    post = Post.new( title: '', preview: '', body: '')
    post.valid?

    expect(post.errors[:title]).to_not be_empty
    expect(post.errors[:preview]).to_not be_empty
    expect(post.errors[:body]).to_not be_empty
  end
end
