class ObjectsProductsController < ApplicationController
  def index
    @products = ObjectsProduct.all
  end
end
