class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.valid?
      @invoice.invoice_number = Invoice.all.empty? ? 10_001 : Invoice.maximum(:invoice_number) + 1
      # Update each product's invoice number
      @invoice.products = Product.where(id: params[:invoice][:product_ids])
      @invoice.products.each { |product| product.sold = true }
      @invoice.save
      redirect_to invoice_path(@invoice)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def edit
  # end

  def show
    @invoice = Invoice.find(params[:id])

    @sub_total = 0
    @invoice.products.each do |product|
      @sub_total += product.unit_price
    end
  end

  # def update
  # end

  # def destroy
  # end

  private

  def invoice_params
    params.require(:invoice).permit(:order_date, :billed_to, :shipping_fee, :discount, products_attributes: [:sku])
  end
end
