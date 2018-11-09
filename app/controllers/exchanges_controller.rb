class ExchangesController < ApplicationController

  def show
    exchange = Exchange.find(params[:id])
    payins = Payin.where(exchange_id: params[:id]).select(:id, :timestamp, :amount)
    payouts = Payout.where(exchange_id: params[:id]).select(:id, :timestamp, :amount)
    render json: {status: 'SUCCESS', data: [payins: payins, payouts: payouts]}, status: :ok
  end

end
