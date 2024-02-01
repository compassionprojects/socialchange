# DiscussionsController
#
class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story, only: %i[new create index show]
  before_action :set_discussion, except: %i[new create index]

  def new
    @discussion = Discussion.new(**creator, story: @story)
    authorize @discussion
  end

  def create
    @discussion = Discussion.new(**creator, story: @story)
    @discussion.assign_attributes(permitted_attributes(@discussion))
    authorize @discussion

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to story_discussion_url(@discussion.story, @discussion), notice: I18n.t("discussions.created") }
        format.json { render :show, status: :created, location: @discussion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @discussions = policy_scope(Discussion).includes(:user).where(story: @story).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @posts = policy_scope(Post).includes(:user).where(discussion: @discussion).order(created_at: :asc).page(params[:page])
  end

  def edit
    authorize @discussion
  end

  def update
    authorize @discussion

    respond_to do |format|
      if @discussion.update(**permitted_attributes(@discussion), updater: current_user)
        format.html { redirect_to story_discussion_url(@discussion.story, @discussion) }
        format.json { render :show, status: :ok, location: @discussion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @discussion
    @discussion.discard

    respond_to do |format|
      format.html { redirect_to story_discussions_url(@discussion.story), notice: I18n.t("discussions.deleted") }
      format.json { render status: :no_content }
    end
  end

  private

  def set_story
    @story = policy_scope(Story).includes(:user).find(params[:story_id])
  end

  def set_discussion
    @discussion = @story.discussions.find(params[:id])
    # @discussion = policy_scope(Discussion).includes(:user).find_by(id: params[:id], story_id: params[:story_id])
  end
end
