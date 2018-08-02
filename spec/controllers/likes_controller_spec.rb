require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before(:each) do
    User.create(name: 'Fred', email: 'fred@email.com', password: 'password')
    Post.create(message: 'test message')
  end

  describe "POST #create" do
    it "creates a new like in the database" do
      post :create, :params => {:like => {:user_id => "#{User.all[0].id}", :post_id => "#{Post.all[0].id}"}}
      expect(response).to have_http_status(:success)
    end

    it "throws an error if foreign key user_id does not exist" do
      expect { post :create, :params => {:like => {:user_id => 5, :post_id => 1}} }.to raise_error
    end

    it "throws an error if foreign key post_id does not exist" do
      expect { post :create, :params => {:like => {:user_id => 1, :post_id => 5}} }.to raise_error
    end
  end
end