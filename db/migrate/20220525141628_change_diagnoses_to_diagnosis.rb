class ChangeDiagnosesToDiagnosis < ActiveRecord::Migration[6.1]
  def change
    rename_table :diagnosis, :diagnosises
  end
end
