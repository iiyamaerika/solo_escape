class CreateDiagnoses < ActiveRecord::Migration[6.1]
  def change
    create_table :diagnosis do |t|
      t.string :question

      t.timestamps
    end
  end
end
