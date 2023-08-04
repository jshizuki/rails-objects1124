class ObjectsInvoicesController < ApplicationController
  before_action :find_invoice, only: %i[show edit update destroy]

  def index
    @invoices = ObjectsInvoice.all
  end

  def new
    @invoice = ObjectsInvoice.new
  end

  def create
    build_invoice
    if @invoice.save
      redirect_to objects_invoice_path(@invoice)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @sub_total = 0
    @invoice.objects_products.each do |product|
      @sub_total += product.unit_price
    end

    @discount = ((@invoice.discount / 100.to_f) * @sub_total).round
    @total = @sub_total + @invoice.shipping_fee - @discount
  end

  def edit; end

  def update
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

  def destroy
    # @article.destroy will do the same job but is generally preferred if there're callback actions
    sold_products = @invoice.objects_products
    sold_products.each do |product|
      product.update(objects_invoice_id: nil, sold: false)
    end
    @invoice.delete
    redirect_to objects_invoices_path, status: :see_other
  end

  private

  def find_invoice
    @invoice = ObjectsInvoice.find(params[:id])
  end

  def build_invoice
    @invoice = ObjectsInvoice.new(invoice_params)
    @invoice.invoice_number = ObjectsInvoice.all.empty? ? 10_001 : ObjectsInvoice.maximum(:invoice_number) + 1
    @invoice.save
    associate_with_products(@invoice)
  end

  def associate_with_products(invoice)
    invoice.objects_products = ObjectsProduct.where(id: params[:objects_invoice][:objects_product_ids])
    invoice.objects_products.update_all(sold: true)
    invoice
  end

  def invoice_params
    params.require(:objects_invoice).permit(:order_date, :billed_to, :shipping_fee, :discount)
  end
end
