class AddPolymorphismToProperty < ActiveRecord::Migration[5.1]
  def change
    add_reference :properties, :propertible, polymorphic: true, index: true
  end
end
