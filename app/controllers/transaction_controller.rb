class TransactionController < ApplicationController

  def index
    current_cnab = CnabUpload.last

    @transactions = []

    unless current_cnab.nil?
      @transactions = Transaction
                          .where(cnab_upload_id: current_cnab.id)
                          .order(store: :asc)
                          .order(transaction_date: :asc)
                          .order(transaction_time: :asc)
                          .group_by(&:store)
    end
  end

end
