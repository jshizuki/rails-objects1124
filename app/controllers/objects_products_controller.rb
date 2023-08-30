class ObjectsProductsController < ApplicationController
  def index
    @products = ObjectsProduct.all
  end

  def new
    @product = ObjectsProduct.new
  end

  def create
    product_params[:quantity].to_i.times do
      @product = ObjectsProduct.new(product_params)
      @product.sku = calculate_sku
      @product.quantity = 1
      @product.save
    end
    redirect_to objects_products_path
  end

  private

  def product_params
    params.require(:objects_product).permit(
      :name,
      :unit_price,
      :quantity
    )
  end

  def calculate_sku
    previous_sku = ObjectsProduct.maximum(:sku)
    numeric_part = previous_sku[3..].to_i
    incremented_numeric_part = (numeric_part + 1).to_s.rjust(previous_sku.length - 3, '0')
    "OBJ#{incremented_numeric_part}"
  end
end
