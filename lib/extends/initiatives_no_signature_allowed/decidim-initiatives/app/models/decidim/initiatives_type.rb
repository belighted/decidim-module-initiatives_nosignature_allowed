# frozen_string_literal: true

require "active_support/concern"

module InitiativesNoSignatureAllowed
  module InitiativesTypeExtend
    extend ActiveSupport::Concern

    included do

      def no_signature_allowed_visible_for?(user)
        return true if user.admin?
        return true if organization&.initiatives_settings.blank?
        return organization.initiatives_settings["allow_users_to_see_initiative_no_signature_option"]
      end

    end
  end

  ::Decidim::InitiativesType.send(:include, InitiativesTypeExtend)
end
