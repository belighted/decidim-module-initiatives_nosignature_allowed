# frozen_string_literal: true

require "active_support/concern"

module InitiativesNoSignatureAllowed
  module RegisterOrganizationExtend
    extend ActiveSupport::Concern

    included do

      private

      def create_organization
        Decidim::Organization.create!(
          name: form.name,
          host: form.host,
          secondary_hosts: form.clean_secondary_hosts,
          reference_prefix: form.reference_prefix,
          available_locales: form.available_locales,
          available_authorizations: form.clean_available_authorizations,
          users_registration_mode: form.users_registration_mode,
          force_users_to_authenticate_before_access_organization: form.force_users_to_authenticate_before_access_organization,
          allow_users_to_see_initiatives_no_signature_option: form.allow_users_to_see_initiatives_no_signature_option,
          badges_enabled: true,
          user_groups_enabled: true,
          default_locale: form.default_locale,
          omniauth_settings: form.encrypted_omniauth_settings,
          smtp_settings: form.encrypted_smtp_settings,
          send_welcome_notification: true
        )
      end

    end
  end

  ::Decidim::System::RegisterOrganization.send(:include, RegisterOrganizationExtend)
end