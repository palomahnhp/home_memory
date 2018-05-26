class AddSpecialityToHistory < ActiveRecord::Migration[5.1]
  def change
    add_reference :histories, :speciality, index: true, foreign_key: true
  end
end
