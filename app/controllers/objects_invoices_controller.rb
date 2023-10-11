class ObjectsInvoicesController < ApplicationController
  before_action :find_invoice, only: %i[show edit update destroy]

  def index
    @invoices = ObjectsInvoice.all
  end

  def new
    @invoice = ObjectsInvoice.new
    products_to_display
  end

  def create
    build_invoice
    if @invoice.save
      # Remove all bookmarks for the next new invoice
      remove_bookmarks
      redirect_to objects_invoice_path(@invoice)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @sub_total = calculate_sub_total
    @discount = calculate_discount
    @total = calculate_total
  end

  def edit
    products_to_display
  end

  def update
    update_sold_products
    update_invoice
    remove_bookmarks
    redirect_to objects_invoice_path(@invoice)
  end

  def destroy
    reset_sold_products
    delete_invoice

    redirect_to objects_invoices_path, status: :see_other
  end

  def remove_product_from_invoice
    @product = ObjectsProduct.find(params[:objects_product_id])
    if params[:id].present?
      find_invoice
      # For edit, products in invoice and bookmarked products can be removed
      handle_existing_invoice
    else
      # For new, bookmarked products can be removed (there's no products in invoice yet)
      handle_new_invoice
    end
  end

  private

  # Shared methods

  def find_invoice
    @invoice = ObjectsInvoice.find(params[:id])
  end

  def invoice_params
    params.require(:objects_invoice).permit(
      :order_date,
      :billed_to,
      :shipping_fee,
      :discount_type,
      :discount_input
    )
  end

  def bookmarked_products
    # Returns ObjectsProducts records
    @bookmarked_products = current_objects_user.all_favorited
  end

  def products_to_display
    @products_to_display = case params[:action]
                           when 'new'
                             bookmarked_products
                           when 'edit', 'update'
                             # bookmarked_products + products_in_invoice
                             {
                               newly_bookmarked_products: bookmarked_products,
                               existing_products: products_in_invoice
                             }
                           end
  end

  def remove_bookmarks
    bookmarked_products.each { |product| unfavorite_product(product) }
  end

  def products_in_invoice
    @invoice.objects_products
  end

  def unfavorite_product(product)
    current_objects_user.unfavorite(product)
  end

  def update_products(products, options)
    products.update_all(options)
  end

  # CREATE

  def build_invoice
    # @invoice = ObjectsInvoice.find(params[:id])
    @invoice = ObjectsInvoice.new(invoice_params)
    @invoice.invoice_number = ObjectsInvoice.all.empty? ? 10_001 : ObjectsInvoice.maximum(:invoice_number) + 1
    @invoice.save
    associate_with_products(@invoice)
  end

  def associate_with_products(invoice)
    invoice.objects_products = bookmarked_products
    # Before favorite gem setup -- ObjectsProduct.where(id: params[:objects_invoice][:objects_product_ids])
    # invoice.objects_products.update_all(sold: true)
    update_products(invoice.objects_products, sold: true)
    invoice
  end

  # SHOW

  def calculate_sub_total
    products_in_invoice.sum(&:unit_price)
  end

  def calculate_discount
    return 0 if @invoice.discount_input.nil?

    if @invoice.discount_type == 'percentage'
      ((@invoice.discount_input / 100.0) * @sub_total).round
    else
      @invoice.discount_input
    end
  end

  def calculate_total
    shipping_fee = @invoice.shipping_fee || 0
    @sub_total - @discount + shipping_fee
  end

  # UPDATE

  def reset_sold_products
    # products_in_invoice.update_all(objects_invoice_id: nil, sold: false)
    update_products(products_in_invoice, objects_invoice_id: nil, sold: false)
  end

  def update_sold_products
    # new_sold_products = ObjectsProduct.where(id: params[:objects_invoice][:objects_product_ids])
    # new_sold_products.update_all(objects_invoice_id: @invoice.id, sold: true)

    # Convert array into Active Record associations before update_all
    sku_values = (products_to_display[:newly_bookmarked_products] + products_to_display[:existing_products]).map(&:sku)

    products_to_be_updated = ObjectsProduct.where(sku: sku_values)
    # products_to_be_updated.update_all(objects_invoice_id: @invoice.id, sold: true)
    update_products(products_to_be_updated, objects_invoice_id: @invoice.id, sold: true)
  end

  def update_invoice
    @invoice.update(invoice_params)
  end

  # DESTROY

  def delete_invoice
    @invoice.delete
  end

  # REMOVE PRODUCT FROM INVOICE

  def handle_existing_invoice
    if @product.objects_invoice_id.present?
      @product.update(objects_invoice_id: nil, sold: false)
    else
      unfavorite_product(@product)
    end
    redirect_to edit_objects_invoice_path(@invoice), status: :see_other
  end

  def handle_new_invoice
    unfavorite_product(@product)
    redirect_to new_objects_invoice_path, status: :see_other
  end
end
