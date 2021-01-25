# frozen_string_literal: true

require "active_support/concern"

module InitiativesNoSignatureAllowed
  module RegisterOrganizationFormExtend
    extend ActiveSupport::Concern

    included do

      attribute :allow_users_to_see_initiatives_no_signature_option, Virtus::Attribute::Boolean

    end
  end

  ::Decidim::System::RegisterOrganizationForm.send(:include, RegisterOrganizationFormExtend)
end
