class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
    # This will create a new, unsaved product instance
    # @invoice.products.build
  end

  # def create
  #   @invoice = Invoice.new(invoice_params)
  #   # @product = Product.find_by_sku(invoice_params[:products_attributes].values.map { |product| product[:sku] })

  #   if @invoice.save
  #     sku_values = invoice_params[:products_attributes].values.map { |product| product[:sku] }
  #     @products = Product.where(sku: sku_values)
  #     @products.each do |product|
  #       product.update(invoice_id: @invoice.id)
  #     end
  #     redirect_to invoice_path(@invoice)
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      sku_values = invoice_params[:products_attributes].values.map { |product| product[:sku] }
      # Retrieve product instances except the last one created from new
      @products = Product.where(sku: sku_values)[1..]

      @products.each do |product|
        product.update(invoice: @invoice)
      end

      redirect_to invoice_path(@invoice)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def edit
  # end

  def show
    @invoice = Invoice.find(params[:id])
  end

  # def update
  # end

  # def destroy
  # end

  private

  def invoice_params
    params.require(:invoice).permit(:order_date, :billed_to, products_attributes: [:sku])
  end
end
