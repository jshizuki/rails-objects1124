class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  # Creating a new invoice whenever there's a transaction
  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.save
    redirect_to invoice_path(@invoice)
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
    params.require(:invoice).permit(:order_date, :billed_to)
  end

end
