class Transaction < ApplicationRecord

  CNAB_PARSER = {
      type: { start: 1, end: 1, field_name: 'transaction_type' },
      date: { start: 2, end: 9, field_name: 'transaction_date', normalize: 'date' },
      value: { start: 10, end: 19, field_name: 'value', normalize: 'value' },
      tax_number: { start: 20, end: 30, field_name: 'tax_number' },
      card: { start: 31, end: 42, field_name: 'card' },
      time: { start: 43, end: 48, field_name: 'transaction_time', normalize: 'time' },
      responsible_name: { start: 49, end: 62, field_name: 'responsible_name', normalize: 'trim' },
      store: { start: 63, end: 81, field_name: 'store', normalize: 'trim' },
  }

  TRANSACTION_TYPES = [
      { param: 1, label: 'Débito', signal: '+' },
      { param: 2, label: 'Boleto', signal: '-' },
      { param: 3, label: 'Financiamento', signal: '-' },
      { param: 4, label: 'Crédito', signal: '+' },
      { param: 5, label: 'Recebimento Empréstimo', signal: '+' },
      { param: 6, label: 'Vendas', signal: '+' },
      { param: 7, label: 'Recebimento TED', signal: '+' },
      { param: 8, label: 'Recebimento DOC', signal: '+' },
      { param: 9, label: 'Aluguel', signal: '-' },
  ]

  def self.process_cnab cnab_upload_id
    cnab_rows = CnabUploadContent.where cnab_upload_id: cnab_upload_id

    transaction_rows = []

    cnab_rows.each do |row|
      row_parsed = self.parse_row row.row_content
      row_parsed[:cnab_upload_id] = cnab_upload_id

      transaction_rows << row_parsed
    end

    Transaction.create transaction_rows
  end

  def self.parse_row row
      row_parsed = {}

      CNAB_PARSER.each do |id, parser|
        start_param = parser[:start] - 1
        end_param = parser[:end] - 1

        content = row[start_param..end_param]

        unless parser[:normalize].nil?
          case parser[:normalize]
          when 'trim'
            content = content.strip

          when 'value'
            content = content.to_f / 100

          when 'time'
            content = content.gsub /(\d{2})(\d{2})(\d{2})/, '\1:\2:\3'

          when 'date'
            content = content.gsub /(\d{4})(\d{2})(\d{2})/, '\1-\2-\3'

          else
            content
          end
        end

        row_parsed[parser[:field_name]] = content
      end

      row_parsed
    end

end
