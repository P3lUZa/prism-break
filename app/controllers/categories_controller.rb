class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @parent_path = root_path
    @page_title = t 'v.categories.all'
    @categories = Category.all
  end

  # GET /categories/1/all
  def all
    @category = Category.find(params[:id])
    @parent_path = @category
    @page_title = "#{@category.title} &rsaquo; #{t('noun.All')}".html_safe
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @parent_path = parent_path
    @page_title = @category.title
  end

  # GET /categories/new
  def new
    @parent_path = categories_path
    @page_title = t 'v.categories.new'
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @parent_path = @category
    @page_title = t 'v.categories.edit'
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:title, :description)
    end

    def parent_path
      if @category.parent_id != nil
        @category.parent
      else
        root_path
      end
    end

end
