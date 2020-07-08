# frozen_string_literal: true
require "active_support/concern"

module InitiativesNoSignatureAllowed
  module InitiativeFormExtend
    extend ActiveSupport::Concern

    included do

      attribute :no_signature, Virtus::Attribute::Boolean

      validate :check_no_signature

      def check_no_signature
        return true if no_signature.blank?

        # errors.add(:no_signature, I18n.t("activemodel.errors.models.initiatives.no_signature_allowed")) unless type.no_signature_allowed?
        errors.add(:no_signature, I18n.t("activemodel.errors.models.initiatives.no_signature_allowed")) unless form.context.initiative_type.no_signature_allowed?
      end

    end
  end

  ::Decidim::Initiatives::InitiativeForm.send(:include, InitiativeFormExtend)
end

