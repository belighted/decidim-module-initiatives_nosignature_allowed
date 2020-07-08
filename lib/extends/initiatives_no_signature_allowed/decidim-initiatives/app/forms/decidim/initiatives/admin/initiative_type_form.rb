# frozen_string_literal: true
require "active_support/concern"

module InitiativesNoSignatureAllowed
  module InitiativeTypeFormExtend
    extend ActiveSupport::Concern

    included do

      attribute :no_signature_allowed, Virtus::Attribute::Boolean

    end
  end

  ::Decidim::Initiatives::Admin::InitiativeTypeForm.send(:include, InitiativeTypeFormExtend)
end

