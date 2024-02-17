module Admin
  class CategoriesController < Admin::ApplicationController
    def index
      @categories = Category.arrange_serializable { |parent, children| {**parent.attributes, children:, title: parent.name} }
      super
    end

    def update_tree
      respond_to do |format|
        format.json do
          parent = (params[:parent_id] != "root") ? Category.find(params[:parent_id]) : nil
          category = Category.find(params[:id])
          category.update! parent: parent

          head :ok
        end
      end
    end
  end
end
