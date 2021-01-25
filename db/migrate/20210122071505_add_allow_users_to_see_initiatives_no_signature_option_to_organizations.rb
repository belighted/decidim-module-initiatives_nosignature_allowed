# frozen_string_literal: true

class AddAllowUsersToSeeInitiativesNoSignatureOptionToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :allow_users_to_see_initiatives_no_signature_option, :boolean, default: true
  end
end
