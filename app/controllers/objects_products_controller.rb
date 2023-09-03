class ObjectsProductsController < ApplicationController
  def index
    @products = ObjectsProduct.all
  end

  def new
    @product = ObjectsProduct.new
  end

  def create
    first_instance = nil
    product_params[:quantity].to_i.times do |index|
      @product = ObjectsProduct.new(product_params.except(:photo))

      if index.zero?
        @product.photo.attach(product_params[:photo])
        first_instance = @product
      else
        @product.photo.attach(first_instance.photo.blob)
      end
      @product.sku = calculate_sku
      @product.quantity = 1
      render :new, status: :unprocessable_entity unless @product.save
    end
    redirect_to objects_products_path
  end

  private

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
end
