class AddProcessToHistory < ActiveRecord::Migration[5.1]
  def change
    add_reference :histories, :process, references: :histories
  end
end
