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
    @sub_total = calculate_sub_total
    @percent_discount = calculate_percent_discount
    @amount_discount = calculate_amount_discount
    @discount = @percent_discount + @amount_discount
    @total = calculate_total
  end

  def edit; end

  def update
    reset_sold_products
    update_sold_products
    update_invoice

    redirect_to objects_invoice_path(@invoice)
  end

  def destroy
    reset_sold_products
    delete_invoice

    redirect_to objects_invoices_path, status: :see_other
  end

  private

  def find_invoice
    @invoice = ObjectsInvoice.find(params[:id])
  end

  # CREATE

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

  # SHOW

  def calculate_sub_total
    @invoice.objects_products.sum(&:unit_price)
  end

  def calculate_percent_discount
    return 0 if @invoice.discount_percentage.nil?

    ((@invoice.discount_percentage / 100.0) * @sub_total).round
  end

  def calculate_amount_discount
    return 0 if @invoice.discount_amount.nil?

    @invoice.discount_amount
  end

  def calculate_total
    shipping_fee = @invoice.shipping_fee || 0
    @sub_total - @discount + shipping_fee
  end

  # UPDATE

  def reset_sold_products
    @invoice.objects_products.update_all(objects_invoice_id: nil, sold: false)
  end

  def update_sold_products
    new_sold_products = ObjectsProduct.where(id: params[:objects_invoice][:objects_product_ids])
    new_sold_products.update_all(objects_invoice_id: @invoice.id, sold: true)
  end

  def update_invoice
    @invoice.update(invoice_params)
  end

  # DESTROY
  def delete_invoice
    @invoice.delete
  end

  def invoice_params
    params.require(:objects_invoice).permit(
      :order_date,
      :billed_to,
      :shipping_fee,
      :discount_percentage,
      :discount_amount
    )
  end
end
