class CreateCnabUploads < ActiveRecord::Migration[6.0]
  def change
    create_table :cnab_uploads do |t|
      t.string :filename

      t.timestamps
    end
  end
end
