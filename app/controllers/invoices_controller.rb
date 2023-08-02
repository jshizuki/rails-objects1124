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
      # Create each product's invoice number
      @invoice.invoice_number = Invoice.all.empty? ? 10_001 : Invoice.maximum(:invoice_number) + 1
      # Update each product's sold status (false --> true)
      @invoice.products = Product.where(id: params[:invoice][:product_ids])
      @invoice.products.each { |product| product.sold = true }
      @invoice.save
      redirect_to invoice_path(@invoice)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @invoice = Invoice.find(params[:id])

    @sub_total = 0
    @invoice.products.each do |product|
      @sub_total += product.unit_price
    end

    @discount = ((@invoice.discount / 100.to_f) * @sub_total).round
    @total = @sub_total + @invoice.shipping_fee - @discount
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    # Reset sold products to false first, then reset invoice number to nil
    sold_products = @invoice.products
    sold_products.each do |product|
      product.update(invoice_id: nil, sold: false)
    end
    # Update sold products
    new_sold_products = Product.where(id: params[:invoice][:product_ids])
    new_sold_products.each do |product|
      product.update(invoice_id: @invoice.id, sold: true)
    end
    @invoice.update(invoice_params)
    redirect_to invoice_path(@invoice)
  end

  # def destroy
  # end

  private

  def invoice_params
    params.require(:invoice).permit(:order_date, :billed_to, :shipping_fee, :discount)
  end
end

# products_attributes: [:sku]
