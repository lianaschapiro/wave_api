class ExchangesController < ApplicationController

  def show
    exchange = Exchange.find(params[:id])
    payins = Payin.where(exchange_id: params[:id]).select(:id, :timestamp, :amount)
    payouts = Payout.where(exchange_id: params[:id]).select(:id, :timestamp, :amount)
    render json: {status: 'SUCCESS', data: [payins: payins, payouts: payouts]}, status: :ok
  end

  def create
    exchange = Exchange.new(exchange_params)
    if exchange.save
      render json: {status: 'SUCCESS', data: exchange}, status: :ok
    else
      render json: {status: 'ERROR', data: exchange.errors}, status: :unprocessable_entry
    end
  end

  # find transactions with duplicate payouts in a given time period
  def duplicates
    # isolate time period from request params
    start_time = params[:from]
    end_time = params[:to]

    exchanges = []
    # target specific payouts in time period
    payouts = Payout.where("timestamp > ? AND timestamp <= ?", start_time, end_time).order('timestamp')

    # iterate through targeted payouts and create transaction array
    payouts.each do |p|
      exchanges.push(p.exchange_id)
    end

    # check for duplicates
    duplicates = exchanges.group_by { |v| v }.select { |k, v| v.count > 1 }.keys
    puts duplicates
    render json: {status: 'SUCCESS', data: [transactions: duplicates]}, status: :ok
  end

end
