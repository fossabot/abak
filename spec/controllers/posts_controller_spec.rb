require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  it_renders_404_page_when_post_is_not_found :show, :edit, :update, :destroy

  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template('index')
    end

    it 'loads all of the posts into @posts' do
      post1, post2 = create(:post), create(:post)
      get :index

      expect(assigns(:posts)).to match_array([post1, post2])
    end
  end

  describe 'GET #show/:id' do
    it 'renders show one article if an post is found with hash params' do
      post = create(:post)
      get :show, { id: post.id }

      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do
    it 'renders form template_new for create new artical' do
      get :new

      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    it 'redirects to new article if validaition was true' do
      post :create, post: { title: 'Test title', preview: 'Test preview', body: 'Test body', category_id: '' }

      expect(response).to redirect_to(assigns(:post))
    end

    it 'renders page again with error if validaition fail' do
      post :create, post: { title: nil, preview: nil, body: nil, category_id: '' }

      expect(response).to render_template('new')
    end
  end

  describe 'POST #edit/:id' do
    it 'renders form template with data for change artical' do
      post = create(:post)
      get :edit, { id: post.id }

      expect(response).to render_template('edit')
    end
  end

  describe 'PUT #update/:id' do
    it 'redirects to updated article if validation was true' do
      post = create(:post)
      put :update, id: post.id, post: post.attributes = { title: 'new title', preview: 'new preview', body: 'new body', category_id: '' }

      expect(response).to redirect_to(assigns(:post))
    end

    it 'should re-render edit template on failed update' do
      post = create(:post)
      put :update, id: post.id, post: post.attributes = { title: '', preview: 'new preview', body: 'new body', category_id: '' }

      expect(response).to render_template('edit')
    end
  end

  describe 'destroy action/:id' do
    it 'redirects to index action when an article is destroyed seccessfuly' do
      post = create(:post)
      delete :destroy, id: post.id

      expect(response).to redirect_to(posts_path)
    end
  end

  describe 'set_post', :private do
    it 'just call private method' do
      expect{subject.set_post}.to raise_error(NoMethodError)
    end
  end

  describe 'post_params', :private do
    it 'method for limitation of params[something] just call' do
      expect{subject.post_params}.to raise_error(NoMethodError)
    end
  end
end
