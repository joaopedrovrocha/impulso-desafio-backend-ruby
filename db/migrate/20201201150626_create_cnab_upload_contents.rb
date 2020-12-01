class CreateCnabUploadContents < ActiveRecord::Migration[6.0]
  def change
    create_table :cnab_upload_contents do |t|
      t.belongs_to :cnab_upload
      t.text :row_content

      t.timestamps
    end
  end
end
