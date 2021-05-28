# frozen_string_literal: true

require "active_support/concern"

module InitiativesNoSignatureAllowed
  module UpdateOrganizationFormExtend
    extend ActiveSupport::Concern

    included do

      jsonb_attribute :initiatives_settings, [
        [:allow_users_to_see_initiative_no_signature_option, Boolean]
      ]

      def map_model(model)
        self.secondary_hosts = model.secondary_hosts.join("\n")
        self.omniauth_settings = (model.omniauth_settings || {}).transform_values do |v|
          Decidim::OmniauthProvider.value_defined?(v) ? Decidim::AttributeEncryptor.decrypt(v) : v
        end
        if model.initiatives_settings.blank?
          self.initiatives_settings = {
            allow_users_to_see_initiative_no_signature_option: true # default is `true`
          }
        end
        self.file_upload_settings = Decidim::System::FileUploadSettingsForm.from_model(model.file_upload_settings)
      end

    end
  end

  ::Decidim::System::UpdateOrganizationForm.send(:include, UpdateOrganizationFormExtend)
end
