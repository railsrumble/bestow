require "rails_helper"

describe ListsController do
  describe "POST #create" do
    context "with invalid params" do
      it "renders the new template" do
        allow(subject).to receive(:current_user).
          and_return(build_stubbed(:user))
        post :create, list: { name: nil }

        expect(response).to render_template(:index)
      end
    end
  end
end
