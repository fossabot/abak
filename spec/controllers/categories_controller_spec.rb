require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  it_renders_404_page_when_category_is_not_found :show, :edit, :update, :destroy

  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index

      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template('index')
    end
  end

  describe 'GET #show/:id' do
    it 'renders show one article if an category is found with hash params' do
      category = create(:category)
      get :show, { params: { id: category.id } }

      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do
    it 'renders form template_new for create new artical' do
      get :new

      expect(response).to render_template('new')
    end
  end

  describe 'GET #add/:id' do
    it 'renders form template_new for create new artical' do
      category = create(:category)
      get :add, { params: { id: category.id } }

      expect(response).to render_template('add')
    end
  end

  describe 'category #create' do
    it 'redirects to new article if validaition was true' do
      post :create, { params: { name: 'newCategory' } }

      expect(response).to redirect_to(assigns(:category))
    end

    it 'renders page again with error if validaition fail' do
      post :create, { params: { name: nil } }

      expect(response).to render_template('add')
    end
  end

  describe 'category #edit/:id' do
    it 'renders form template with data for change artical' do
      category = create(:category)
      get :edit, { params: { id: category.id } }

      expect(response).to render_template('edit')
    end
  end

  describe 'PUT #update/:id' do
    it 'redirects to updated article if validation was true' do
        category = create(:category)
        put :update, { params: { id: category.id, name: 'newTitle' } }

        expect(response).to redirect_to(categories_path)
    end

    it 'should re-render edit template on failed update' do
        category = create(:category)
        put :update, { params: { id: category.id, name: '' } }

        expect(response).to render_template('edit')
    end

    it 'should redirect to #add/id if name of category descendant of itself' do
      category = create(:category)
      put :update, { params: { id: category.id, name: '', ancestry: category.id } }

      expect(response).to be_success
    end
  end

  describe 'destroy action/:id' do
    it 'redirects to index action when an article is destroyed seccessfuly' do
      category = create(:category)
      delete :destroy, { params: { id: category.id } }

      expect(response).to redirect_to(categories_path)
    end
  end
end
