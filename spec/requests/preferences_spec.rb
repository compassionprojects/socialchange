require "rails_helper"

describe "/preferences", type: :request do
  context "when not logged in" do
    describe "GET /index" do
      it "redirects the user" do
        get preferences_url
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  context "when logged in" do
    let(:user) { create(:user, preference: create(:preference)) }

    before do
      sign_in user
    end

    describe "GET /index" do
      it "renders user preferences" do
        get preferences_url
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(I18n.t("preferences.index.notify_any_post_in_discussion"))
        expect(response.body).to include(I18n.t("preferences.index.notify_new_discussion_on_story"))
        expect(response.body).to include(I18n.t("preferences.index.notify_new_post_on_discussion"))
        expect(response.body).to include(I18n.t("preferences.index.notify_new_story"))
      end
    end
  end
end
