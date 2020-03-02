class AddNoSignatureAllowedToDecidimInitiativeType < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_types, :no_signature_allowed, :boolean, default: false
  end
end
