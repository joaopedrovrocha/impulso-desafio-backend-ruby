class CnabController < ApplicationController

  def upload
    upload_io = params[:file]

    cnab_upload = CnabUpload.new filename: upload_io.original_filename
    cnab_upload.save

    content = File.read(upload_io.path)

    unless content
      flash[:error] = 'Conteúdo do arquivo está vazio!'

      return redirect_to index_path
    end

    rows = content.split("\n").map{ |el| { row_content: el, cnab_upload_id: cnab_upload.id } }

    if rows.empty?
      flash[:error] = 'Erro carregar as informações do arquivo.'

      return redirect_to index_path
    end

    rows.each do |row|
      CnabUploadContent.create row
    end

    Transaction.process_cnab cnab_upload.id

    redirect_to transactions_path
  end

end
