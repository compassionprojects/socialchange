require "rails_helper"

describe "posts", type: :request do
  let(:discussion) { create(:discussion) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /new" do
    it "renders a new post form" do
      get new_discussion_post_url(discussion)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    it "creates a discussion post" do
      expect do
        post discussion_posts_url(discussion), params: { post: attributes_for(:post) }
      end.to change(Post, :count).by(1)
    end

    it "redirects to discussion" do
      post discussion_posts_url(discussion), params: { post: attributes_for(:post) }
      expect(response).to redirect_to(story_discussion_url(discussion.story, discussion))
    end
  end

  describe "GET /edit" do
    let(:post) { create(:post, user:) }

    it "renders an edit post form" do
      get edit_post_url(post)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /update" do
    let(:post) { create(:post, user:) }
    let(:new_attrs) { attributes_for(:post) }

    it "updates an existing discussion post" do
      patch post_url(post), params: { post: new_attrs }
      post.reload
      expect(post.body).to eql(new_attrs[:body])
    end

    it "redirects to discussion" do
      patch post_url(post), params: { post: new_attrs }
      expect(response).to redirect_to(story_discussion_url(post.discussion.story, post.discussion))
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested post" do
      post = create(:post, user:)
      expect do
        delete post_url(post)
      end.to change(Post.kept, :count).by(-1)
    end

    it "redirects to the discussion" do
      post = create(:post, user:)
      delete post_url(post)
      expect(response).to redirect_to(story_discussion_url(post.discussion.story, post.discussion))
    end

    it "adds discarded_at timestamp" do
      post = create(:post, user:)
      delete post_url(post)
      post.reload
      expect(post.discarded_at).not_to be_nil
    end
  end

end
