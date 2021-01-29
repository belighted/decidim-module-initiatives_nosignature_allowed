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
        self.omniauth_settings = Hash[(model.omniauth_settings || []).map do |k, v|
          [k, Decidim::OmniauthProvider.value_defined?(v) ? Decidim::AttributeEncryptor.decrypt(v) : v]
        end]
        if model.initiatives_settings.blank?
          self.initiatives_settings = {
            allow_users_to_see_initiative_no_signature_option: true # default is `true`
          }
        end
      end

    end
  end

  ::Decidim::System::UpdateOrganizationForm.send(:include, UpdateOrganizationFormExtend)
end
