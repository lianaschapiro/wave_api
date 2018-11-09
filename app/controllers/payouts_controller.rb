class PayoutsController < ApplicationController

  def create
    payout = Payout.new(payout_params)
    if payout.save
      render json: {status: 200, data:{}}, status: :ok
    else
      render json: {status: 'ERROR', data: payout.errors}, status: :unprocessable_entry
    end
  end

  private

  def payout_params
    params.permit(:timestamp, :amount, :exchange_id)
  end
end
