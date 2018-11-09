class PayinsController < ApplicationController

  def create
    payin = Payin.new(payin_params)
    if payin.save
      render json: {status: 200, data:{}}, status: :ok
    else
      render json: {status: 'ERROR', data: payin.errors}, status: :unprocessable_entry
    end
  end

  private

  def payin_params
    params.permit(:timestamp, :amount, :exchange_id)
  end
end