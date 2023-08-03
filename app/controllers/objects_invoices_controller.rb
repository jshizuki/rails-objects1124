class ObjectsInvoicesController < ApplicationController
  def index
    @invoices = ObjectsInvoice.all
  end

  def new
    @invoice = ObjectsInvoice.new
  end

  def create
    @invoice = ObjectsInvoice.new(invoice_params)

    if @invoice.valid?
      # Create each product's invoice number
      @invoice.invoice_number = ObjectsInvoice.all.empty? ? 10_001 : ObjectsInvoice.maximum(:invoice_number) + 1
      # Update each product's sold status (false --> true)
      @invoice.objects_products = ObjectsProduct.where(id: params[:objects_invoice][:objects_product_ids])
      @invoice.objects_products.each { |product| product.sold = true }
      @invoice.save
      redirect_to objects_invoice_path(@invoice)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @invoice = ObjectsInvoice.find(params[:id])

    @sub_total = 0
    @invoice.objects_products.each do |product|
      @sub_total += product.unit_price
    end

    @discount = ((@invoice.discount / 100.to_f) * @sub_total).round
    @total = @sub_total + @invoice.shipping_fee - @discount
  end

  def edit
    @invoice = ObjectsInvoice.find(params[:id])
  end

  def update
    @invoice = ObjectsInvoice.find(params[:id])
    # Reset sold products to false first, then reset invoice number to nil
    sold_products = @invoice.objects_products
    sold_products.each do |product|
      product.update(objects_invoice_id: nil, sold: false)
    end
    # Update sold products
    new_sold_products = ObjectsProduct.where(id: params[:objects_invoice][:objects_product_ids])
    new_sold_products.each do |product|
      product.update(objects_invoice_id: @invoice.id, sold: true)
    end
    @invoice.update(invoice_params)
    redirect_to objects_invoice_path(@invoice)
  end

  # def destroy
  # end

  private

  def invoice_params
    params.require(:objects_invoice).permit(:order_date, :billed_to, :shipping_fee, :discount)
  end
end

# products_attributes: [:sku]
