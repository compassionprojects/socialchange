require "rails_helper"

# @todo add stories for ransack / search
# @todo add stories for translated stories listing and switching locales

describe "/story_updates", type: :request do
  describe "GET /new" do
    let(:story) { create(:story) }

    it "redirects the user" do
      get new_story_update_url(story_id: story.id)
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  context "when user is logged in" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    describe "GET /new" do
      let(:story) { create(:story, user:) }

      it "renders a successful response" do
        get new_story_update_url(story_id: story.id)
        expect(response).to be_successful
      end

      context "when user is not creator" do
        let(:story) { create(:story) }

        it "redirects to home page" do
          get new_story_update_url(story_id: story.id)
          expect(response).to redirect_to(root_url)
        end
      end
    end

    describe "GET /edit" do
      let(:story) { create(:story, user:) }
      let(:story_update) { create(:story_update, user:, story:) }

      it "renders a successful response" do
        get edit_story_update_url(story_update)
        expect(response).to be_successful
      end

      context "when user is not creator" do
        let(:story_update) { create(:story_update) }

        it "redirects to home page" do
          get edit_story_update_url(story_update)
          expect(response).to redirect_to(root_url)
        end
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        let(:story) { create(:story, user:) }
        let(:params) { { story_update: attributes_for(:story_update) } }

        it "creates a new story update" do
          expect do
            post story_updates_url(story), params:
          end.to change(StoryUpdate, :count).by(1)
        end

        it "redirects to the story" do
          post story_updates_url(story), params: params
          expect(response).to redirect_to(story_url(story))
        end
      end

      context "with invalid parameters" do
        let(:story) { create(:story, user:) }

        it "does not create a new story update" do
          expect do
            post story_updates_url(story), params: { story_update: { title: "Test title" } } # without description
          end.to change(StoryUpdate, :count).by(0)
        end

        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          post story_updates_url(story), params: { story_update: { description: "Test desc..." } } # without title
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        let(:new_attributes) { attributes_for(:story_update) }

        it "updates the requested story_update" do
          story_update = create(:story_update, story: create(:story, user:), user:)
          patch story_update_url(story_update), params: { story_update: new_attributes }
          story_update.reload
          expect(story_update.title).to eql(new_attributes[:title])
        end

        it "redirects to the story" do
          story_update = create(:story_update, story: create(:story, user:), user:)
          patch story_update_url(story_update), params: { story_update: new_attributes }
          expect(response).to redirect_to(story_url(story_update.story))
        end
      end

      context "when user does not own the story" do
        it "redirects the user to home page" do
          # user who is creating this story is not the logged in user
          story_update = create(:story_update, story: create(:story), user:)
          patch story_update_url(story_update), params: { story_update: { title: "New title..." } }
          expect(response).to redirect_to(root_url)
        end
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested story" do
        story_update = create(:story_update, story: create(:story, user:), user:)
        expect do
          delete story_update_url(story_update)
        end.to change(StoryUpdate.kept, :count).by(-1)
      end

      it "redirects to the story" do
        story_update = create(:story_update, story: create(:story, user:), user:)
        delete story_update_url(story_update)
        expect(response).to redirect_to(story_url(story_update.story))
      end

      it "adds discarded_at timestamp" do
        story_update = create(:story_update, story: create(:story, user:), user:)
        delete story_update_url(story_update)
        story_update.reload
        expect(story_update.discarded_at).not_to be_nil
      end
    end
  end
end
