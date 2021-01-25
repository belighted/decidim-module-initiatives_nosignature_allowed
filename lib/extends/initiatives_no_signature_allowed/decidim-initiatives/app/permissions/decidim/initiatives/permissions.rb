# frozen_string_literal: true

require "active_support/concern"

module InitiativesNoSignatureAllowed
  module PermissionsExtend
    extend ActiveSupport::Concern

    included do
      private

      def can_vote?
        return if initiative.no_signature?

        initiative.votes_enabled? &&
          initiative.organization&.id == user.organization&.id &&
          initiative.votes.where(author: user).empty? &&
          authorized?(:vote, resource: initiative, permissions_holder: initiative.type)
      end
    end
  end

  ::Decidim::Initiatives::Permissions.send(:include, PermissionsExtend)
end
