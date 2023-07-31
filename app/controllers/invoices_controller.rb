class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)

    @initial_invoice_number = 10_000

    if @invoice.save
      @invoice.invoice_number = Invoice.maximum(:invoice_number) + 1
      @invoice.save
      @invoice.products = Product.where(id: params[:invoice][:product_ids])
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
    params.require(:invoice).permit(:order_date, :billed_to, products_attributes: [:sku])
  end
end
