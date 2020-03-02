class AddNoSignatureToDecidimInitiative < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives, :no_signature, :boolean, default: false
  end
end
