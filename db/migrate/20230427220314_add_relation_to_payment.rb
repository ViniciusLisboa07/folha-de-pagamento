class AddRelationToPayment < ActiveRecord::Migration[7.0]
  def change
    add_reference :payments, :employees, index: true
  end
end
