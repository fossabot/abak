require 'rails_helper'

describe Post do
  let!(:post) { create(:post) }

  it 'renders html body' do
    post.update_attribute(:body, '# Hello')

    expect(markdown post.body).to match('<h1>Hello</h1>\n')
  end

  it 'renders bold from ** for body' do
    post.update_attribute(:body, '**Hello**')

    expect(markdown post.body).to match('<p><b>Hello</b></p>\n')
  end

  it 'renders italics from \\ for body (standart method with emphasis)' do
    post.update_attribute(:body, '*Hello*')

    expect(markdown post.body).to match('<p><i>Hello</i></p>\n')
  end

  it 'renders link from [string](/name1/name2/name3) for body (Reverse example)' do
    post.update_attribute(:body, '[string](/name1/name2/name3)')

    expect(markdown post.body).to match('<p><a href="/name1/name2/name3">string</a></p>')
  end
end
