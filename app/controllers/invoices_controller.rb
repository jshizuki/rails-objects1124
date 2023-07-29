class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  # def create
  # end

  # Creating a new invoice whenever there's a transaction
  def new
    @invoice = Invoice.new
  end

  # def edit
  # end

  # def show
  # end

  # def update
  # end

  # def destroy
  # end
end
