class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    product_params = params.require(:product).permit([:name, :description, :price])
    @product = Product.new product_params
    if @product.save
      render text: "SUCCESS"
    else
      render :new
    end
    # render text: params
  end

  def show
    @product = Product.find params[:id]
  end

  def index
    @products = Product.all
  end

  def edit
    # we need to find the question that will be edited
    @product = Product.find params[:id]
  end

  def update
    # we need to feth the question first to update it
    @product = Product.find params[:id]
    # we must use strong params to only allow updating the title/body
    product_params = params.require(:product).permit([:name, :description, :price])
    #we call the update with sanitized params
    if @product.update product_params
    # we redirect to the question show page
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy
    # can use delete but will skip callbacks
    # we redirect to the index page
    redirect_to products_path
  end
end
