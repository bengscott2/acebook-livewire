require 'rails_helper'

RSpec.describe ChatController, type: :controller do
  before(:each) do
    allow(controller).to receive(:authenticate_user!).and_return(true)
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
