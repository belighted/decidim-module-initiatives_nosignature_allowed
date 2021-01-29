# frozen_string_literal: true

class AddInitiativesSettingsToDecidimOrganizations < ActiveRecord::Migration[5.2]
  def change
    unless column_exists? :decidim_organizations, :initiatives_settings
      add_column :decidim_organizations, :initiatives_settings, :jsonb
    end

    if column_exists? :decidim_organizations, :allow_users_to_see_initiatives_no_signature_option
      remove_column :decidim_organizations, :allow_users_to_see_initiatives_no_signature_option
    end
  end
end
