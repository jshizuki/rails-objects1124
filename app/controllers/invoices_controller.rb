class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
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
