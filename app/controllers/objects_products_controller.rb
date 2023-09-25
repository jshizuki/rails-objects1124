class ObjectsProductsController < ApplicationController
  before_action :find_product, only: %i[edit update toggle_bookmark]

  def index
    display_options = {
      'available' => [:id],
      'oldest' => [:id],
      'newest' => [{ id: :desc }],
      'price_lowest' => %i[unit_price id],
      'price_highest' => [{ unit_price: :desc }, :id]
    }

    default_display_option = [:id]
    display_option = display_options[params[:display]] || default_display_option

    # Store the current displaying option in a SESSION VARIABLE
    session[:current_display_option] = params[:display]

    @products = if params[:display] == 'available'
                  ObjectsProduct.where(sold: false).sort
                else
                  ObjectsProduct.order(display_option)
                end
  end

  def new
    @product = ObjectsProduct.new
  end

  def create
    first_instance = nil
    product_params[:quantity].to_i.times do |index|
      @product = ObjectsProduct.new(product_params.except(:photo))

      if index.zero?
        attach_photo_to_one_product
        first_instance = @product
      else
        @product.photo.attach(first_instance.photo.blob)
      end

      @product.sku = calculate_sku
      @product.quantity = 1
      render :new, status: :unprocessable_entity unless @product.save
    end

    redirect_to objects_products_path(sort: session[:current_sort_option])
  end

  def edit; end

  def update
    # Use SQL query to find other relevant instances based on their name.
    # Note that "update_all" only works on active record relations, NOT arrays
    relevant_products = ObjectsProduct.where(name: @product.name)
    unsold_relevant_products = relevant_products.where(sold: false)
    sold_relevant_products = relevant_products.where(sold: true)

    attach_photo_to_one_product
    relevant_products.each { |product| product.photo.attach(@product.photo.blob) }

    product_params_hash = product_params.except(:photo).to_h

    if unsold_relevant_products.update_all(product_params_hash) && sold_relevant_products.update_all(product_params_hash.except(:unit_price))
      # Redirect back to the index page with the sorting option from the session
      redirect_to objects_products_path(sort: session[:current_sort_option])
    else
      render :new, status: :unprocessable_entity
    end
  end

  def toggle_bookmark
    user = current_objects_user
    user.favorited?(@product) ? user.unfavorite(@product) : user.favorite(@product)
  end

  private

  def find_product
    @product = ObjectsProduct.find(params[:id])
  end

  def product_params
    params.require(:objects_product).permit(
      :name,
      :unit_price,
      :quantity,
      :photo
    )
  end

  def calculate_sku
    previous_sku = ObjectsProduct.maximum(:sku)
    numeric_part = previous_sku[3..].to_i
    incremented_numeric_part = (numeric_part + 1).to_s.rjust(previous_sku.length - 3, '0')
    "OBJ#{incremented_numeric_part}"
  end

  def attach_photo_to_one_product
    @product.photo.attach(product_params[:photo])
  end
end
