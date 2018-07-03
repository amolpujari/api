class Sequel::Model
  def self.order_by *cols
    cols = [cols].flatten.compact.uniq
    @order_by_columns ||= [(self.columns && cols)].flatten.map(&:to_s)
  end

  def self.order_by_columns
    @order_by_columns ||= []
  end

  def self.permit *cols
    cols = [cols].flatten.compact.uniq
    @permitted_columns ||= [(self.columns && cols)].flatten
  end

  def self.permitted_columns
    @permitted_columns ||= []
  end
end


DB = Sequel::Model.db rescue nil

if DB
  DB.extension :pagination
end
