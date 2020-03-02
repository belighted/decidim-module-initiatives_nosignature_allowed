class AddNosignatureAllowedToDecidimInitiativeType < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_types, :no_signature, :boolean, default: false
  end
end
