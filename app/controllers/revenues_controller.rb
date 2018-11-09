class RevenuesController < ApplicationController

  # calculate revenue in a given time period
  def show
    # isolate time period from request params
    start_time = params[:from]
    end_time = params[:to]

    # set starting amounts for payins/payouts
    payin_total = 0
    payout_total = 0

    # target specific payins / payouts in time period
    payins = Payin.where("timestamp > ? AND timestamp <= ?", start_time, end_time).order('timestamp')
    payouts = Payout.where("timestamp > ? AND timestamp <= ?", start_time, end_time).order('timestamp')

    # iterate through targeted payins to find total payin amount
    payins.each do |p|
      payin_total += p.amount
    end

    # iterate through targeted payouts to find total payout amount
    payouts.each do |p|
      payout_total += p.amount
    end

    # calculate final revenue
    revenue = payin_total - payout_total
    revenue = revenue.round(2)
    render json: {status: 'SUCCESS', data: [revenue: revenue]}, status: :ok
  end

end
