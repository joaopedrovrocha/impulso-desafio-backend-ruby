class AddCnabUploadReference < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :cnab_upload, references: :cnab_upload, index: true
  end
end
