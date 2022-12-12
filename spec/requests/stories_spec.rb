require "rails_helper"

describe "/stories", type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      create(:story)
      get stories_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    let(:story) { create(:story) }

    it "renders a successful response" do
      get story_url(story)
      expect(response).to be_successful
    end
  end

  context "when user is logged in" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_story_url
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      let(:story) { create(:story, user:, updater: user) }

      it "renders a successful response" do
        get edit_story_url(story)
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new Story" do
          expect do
            post stories_url, params: { story: attributes_for(:story) }
          end.to change(Story, :count).by(1)
        end

        it "redirects to the created story" do
          post stories_url, params: { story: attributes_for(:story) }
          expect(response).to redirect_to(story_url(Story.last))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Story" do
          expect do
            post stories_url, params: { story: { title: "Story title" } } # without description
          end.to change(Story, :count).by(0)
        end

        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          post stories_url, params: { story: { description: "Story description" } } # without title
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        let(:new_attributes) { attributes_for(:story) }

        it "updates the requested story" do
          story = create(:story, user:)
          patch story_url(story), params: { story: new_attributes }
          story.reload
          expect(story.title).to eql(new_attributes[:title])
        end

        it "redirects to the story" do
          story = create(:story, user:)
          patch story_url(story), params: { story: new_attributes }
          story.reload
          expect(response).to redirect_to(story_url(story))
        end
      end

      context "when user does not own the story" do
        it "redirects the user to home page" do
          story = create(:story) # user who is creating this story is not the logged in user
          patch story_url(story), params: { story: { title: "test" } }
          expect(response).to redirect_to(root_url)
        end
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested story" do
        story = create(:story, user:)
        expect do
          delete story_url(story)
        end.to change(Story, :count).by(-1)
      end

      it "redirects to the stories list" do
        story = create(:story, user:)
        delete story_url(story)
        expect(response).to redirect_to(stories_url)
      end
    end
  end
end
