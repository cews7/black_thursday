require_relative './time_formatter'

class Merchant
  include TimeFormatter
  attr_reader :name,
              :id,
              :created_at,
              :updated_at

  def initialize(merchant_data, parent = nil)
    @id         = merchant_data[:id].to_i
    @name       = merchant_data[:name].to_s
    @created_at = format_time(merchant_data[:created_at].to_s)
    @updated_at = format_time(merchant_data[:created_at].to_s)
    @parent     = parent
  end

  def items
    @parent.find_items_by_merchant_id(id)
  end

  def invoices
    @parent.find_invoices_by_merchant_id(id)
  end

  def customers
    invoices = @parent.find_invoices_by_merchant_id(id)
    invoices.map do |invoice|
      @parent.find_customer_by_customer_id(invoice.customer_id)
    end.uniq
  end
end
