require "rails_helper"

describe "/discussions", type: :request do
  let(:story) { create(:story) }

  context "when not logged in" do
    describe "GET /index" do
      it "redirects the user" do
        get story_discussions_url(story)
        expect(response).to have_http_status(:redirect)
      end
    end

    describe "GET /new" do
      it "redirects the user" do
        get new_story_discussion_url(story)
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  context "when logged in" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    describe "GET /index" do
      it "renders all discussions of the story" do
        discussions = [create(:discussion, story:), create(:discussion, story:)]
        get story_discussions_url(story)
        expect(response.body).to include(discussions.first.title)
        expect(response.body).to include(discussions.last.title)
        expect(response).to have_http_status(:ok)
      end
    end

    describe "GET /show" do
      let(:discussion) { create(:discussion, story:) }

      it "lists all posts for that topic" do
        posts = [create(:post, discussion:), create(:post, discussion:)]
        get story_discussion_url(story, discussion)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(posts.first.body)
        expect(response.body).to include(posts.last.body)
      end
    end

    describe "GET /new" do
      it "renders the new discussion form" do
        get new_story_discussion_url(story)
        expect(response).to have_http_status(:ok)
      end
    end

    describe "POST /create" do
      it "creates a new discussion" do
        expect do
          post story_discussions_url(story), params: {discussion: attributes_for(:discussion)}
        end.to change(Discussion, :count).by(1)
      end

      it "redirects to the created discussion" do
        post story_discussions_url(story), params: {discussion: attributes_for(:discussion)}
        expect(response).to redirect_to(story_discussion_url(story, Discussion.last))
      end
    end

    xdescribe "creating a new discussion" do
      before { ActiveJob::Base.queue_adapter = :test }

      it "notifies strory creator" do
        story_one = create(:story, user: create(:user))
        expect do
          post story_discussions_url(story_one), params: {discussion: attributes_for(:discussion)}
        end.to have_enqueued_job(Noticed::DeliveryMethods::Email).with(hash_including(notification_class: NewDiscussionNotification.name))
        expect(ApplicationMailer.deliveries.count).to eql(1)
      end

      it "does not notify story creator" do
        story_two = create(:story, user: create(:user, preference: create(:preference, notify_new_discussion_on_story: false)))
        expect do
          post story_discussions_url(story_two), params: {discussion: attributes_for(:discussion)}
          # it does trigger the job but then filtered out in `if: email_notifications?` filter
          # so there's no emails sent
        end.to have_enqueued_job(Noticed::DeliveryMethods::Email).with(hash_including(notification_class: NewDiscussionNotification.name))
        expect(ApplicationMailer.deliveries.count).to eql(0)
      end
    end

    describe "GET /edit" do
      let(:discussion) { create(:discussion, story:, user:) }

      it "renders edit form" do
        get edit_discussion_url(discussion)
        expect(response).to have_http_status(:ok)
      end
    end

    describe "PATCH /update" do
      let(:discussion) { create(:discussion, story:, user:) }
      let(:attrs) { attributes_for(:discussion) }

      it "updates discussion" do
        patch discussion_url(discussion), params: {discussion: attrs}
        discussion.reload
        expect(discussion.title).to eql(attrs[:title])
      end

      it "redirects to discussion show page" do
        patch discussion_url(discussion), params: {discussion: attrs}
        expect(response).to redirect_to(story_discussion_url(discussion.story, discussion))
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested discussion" do
        discussion = create(:discussion, user:)
        expect do
          delete discussion_url(discussion)
        end.to change(Discussion.kept, :count).by(-1)
      end

      it "redirects to the discussions" do
        discussion = create(:discussion, user:)
        delete discussion_url(discussion)
        expect(response).to redirect_to(story_discussions_url(discussion.story))
      end

      it "adds discarded_at timestamp" do
        discussion = create(:discussion, user:)
        delete discussion_url(discussion)
        discussion.reload
        expect(discussion.discarded_at).not_to be_nil
      end
    end
  end
end
