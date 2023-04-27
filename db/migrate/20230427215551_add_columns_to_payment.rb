class AddColumnsToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :mes, :string
    add_column :payments, :ano, :integer
    add_column :payments, :horas, :integer
    add_column :payments, :valor, :integer
  end
end
