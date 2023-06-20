# Stories controller
#
class StoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit create update destroy]
  before_action :set_story, only: %i[show edit update destroy]

  def index
    # Fields to search for
    @search_fields = :title_or_description_or_outcomes_or_source_or_story_updates_title_i_cont_any

    # Inspired from https://github.com/activerecord-hackery/ransack/issues/218#issuecomment-16504630
    # Make sure multiple words are split and searched
    if params[:q]
      params[:q][:combinator] = "or"
      params[:q][:groupings] = []
      custom_words = params[:q][@search_fields]
      params[:q].delete(@search_fields) # delete the default one
      # create new search criteria with the split words
      custom_words.split(" ").each_with_index do |word, index|
        params[:q][:groupings][index] = {"#{@search_fields}": word}
      end
    end

    @q = policy_scope(Story).includes(:user).ransack(params[:q])
    @stories = @q.result(distinct: true).page(params[:page])
  end

  def search
    index
    render :index
  end

  def show
  end

  def new
    @story = Story.new(**creator)
    authorize @story
  end

  def edit
    authorize @story
  end

  def create
    @story = Story.new(**creator)
    @story.assign_attributes(permitted_attributes(@story))
    authorize @story

    respond_to do |format|
      if @story.save
        format.html { redirect_to story_url(@story), notice: I18n.t("stories.created") }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @story
    respond_to do |format|
      attrs = permitted_attributes(@story).reject { |x| x["documents"] }
      if @story.update(**attrs, updater: current_user)
        # Append documents using .attach
        if params[:story][:documents].present?
          params[:story][:documents].each do |doc|
            @story.documents.attach(doc)
          end
        end
        format.html { redirect_to story_url(@story), notice: I18n.t("stories.updated") }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_documents
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge_later
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@attachment)}_container") }
    end
  end

  def destroy
    authorize @story
    @story.discard

    respond_to do |format|
      format.html { redirect_to stories_url, notice: I18n.t("stories.deleted") }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_story
    @story = policy_scope(Story).with_attached_documents.includes(:user, story_updates: [:user]).find(params[:id])
  end
end
