class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  # def create
  # end

  # def new
  # end

  # def edit
  # end

  # def show
  # end

  # def update
  # end

  # def destroy
  # end
end