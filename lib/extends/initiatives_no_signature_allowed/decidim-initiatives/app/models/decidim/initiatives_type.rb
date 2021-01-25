# frozen_string_literal: true

require "active_support/concern"

module InitiativesNoSignatureAllowed
  module InitiativesTypeExtend
    extend ActiveSupport::Concern

    included do

      def no_signature_allowed_visible_for?(user)
        return true if user.admin?
        return organization.allow_users_to_see_initiatives_no_signature_option
      end

    end
  end

  ::Decidim::InitiativesType.send(:include, InitiativesTypeExtend)
end
