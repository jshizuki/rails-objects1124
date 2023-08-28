class ObjectsProductsController < ApplicationController
  def index
    @products = ObjectsProduct.all
  end

  def new
    @product = ObjectsProduct.new
  end

  def create
    @product = ObjectsProduct.new(product_params)
    @product.sku = calculate_sku
    if @product.save
      redirect_to objects_products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:objects_product).permit(
      :name,
      :unit_price
    )
  end

  def calculate_sku
    previous_sku = ObjectsProduct.maximum(:sku)
    numeric_part = previous_sku[3..].to_i
    incremented_numeric_part = (numeric_part + 1).to_s.rjust(previous_sku.length - 3, '0')
    "OBJ#{incremented_numeric_part}"
  end
end
