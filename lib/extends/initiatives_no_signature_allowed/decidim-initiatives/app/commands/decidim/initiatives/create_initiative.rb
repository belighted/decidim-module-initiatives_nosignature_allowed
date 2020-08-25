# frozen_string_literal: true

module InitiativesNoSignatureAllowed
  module CreateInitiativeExtend
    extend ActiveSupport::Concern

    included do
      private

      def build_initiative
        ::Decidim::Initiative.new(
          organization: form.current_organization,
          title: { current_locale => form.title },
          description: { current_locale => form.description },
          author: current_user,
          decidim_user_group_id: form.decidim_user_group_id,
          scoped_type: scoped_type,
          area: area,
          signature_type: form.signature_type,
          signature_end_date: signature_end_date,
          state: "created",
          no_signature: form.no_signature
        )
      end

      def scoped_type
        ::Decidim::InitiativesTypeScope.find_by(
          type: form.initiative_type,
          scope: form.scope # same as: `scope: form.scope_id`
        )
      end
    end
  end

  ::Decidim::Initiatives::CreateInitiative.send(:include, CreateInitiativeExtend)
end
