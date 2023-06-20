# PostsController
#
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_discussion, only: %i[new create]
  before_action :set_post, except: %i[new create]

  def new
    @post = Post.new(**creator, discussion: @discussion)
    authorize @post
  end

  def create
    @post = Post.new(**creator, discussion: @discussion)
    @post.assign_attributes(permitted_attributes(@post))
    authorize @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to story_discussion_url(@discussion.story, @discussion) }
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:posts, partial: "posts/list_item", locals: {post: @post, border_top: true})
        end
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post

    respond_to do |format|
      if @post.update(**permitted_attributes(@post), updater: current_user)
        format.html { redirect_to story_discussion_url(@post.discussion.story, @post.discussion) }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @post
    @post.discard

    respond_to do |format|
      format.html { redirect_to story_discussion_url(@post.discussion.story, @post.discussion), notice: I18n.t("posts.deleted") }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(helpers.dom_id(@post)) }
      format.json { render status: :no_content }
    end
  end

  private

  def set_discussion
    @discussion = policy_scope(Discussion).includes(:user).find(params[:discussion_id])
  end

  def set_post
    @post = policy_scope(Post).find(params[:id])
  end
end
