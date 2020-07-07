# frozen_string_literal: true
require "active_support/concern"

module InitiativeExtend
  extend ActiveSupport::Concern

  included do
    delegate :promoting_committee_enabled?, to: :type

    scope :future_spaces, -> { none }
    scope :past_spaces, -> { closed }
    scope :order_by_supports, -> { order("((online_votes->>'total')::int + (offline_votes->>'total')::int) DESC") }

    # Public: Returns the hashtag for the initiative.
    def hashtag
      @hashtag ||= attributes["hashtag"].to_s.delete("#")
    end

    # Public: Calculates the number of current supports.
    #
    # Returns an Integer.
    def supports_count
      online_votes_count + offline_votes_count
    end

    # Public: Calculates the number of supports required to accept the initiative
    # across all votable scopes.
    #
    # Returns an Integer.
    def supports_required
      @supports_required ||= votable_initiative_type_scopes.sum(&:supports_required)
    end

    # Public: Calculates all the votes across all the scopes.
    #
    # Returns an Integer.
    def online_votes_count
      return 0 if offline_signature_type?

      online_votes["total"].to_i
    end

    def offline_votes_count
      return 0 if online_signature_type?

      offline_votes["total"].to_i
    end

    def online_votes_count_for(scope)
      scope_key = (scope&.id || "global").to_s

      (online_votes || {}).fetch(scope_key, 0).to_i
    end

    def update_online_votes_counters
      # rubocop:disable Rails/SkipsModelValidations
      online_votes = votes.group(:scope).count.each_with_object({}) do |(scope, count), counters|
        counters[scope&.id || "global"] = count
        counters["total"] ||= 0
        counters["total"] += count
      end

      online_votes = { "total": 0 } if online_votes.blank?

      update_column("online_votes", online_votes)
      # rubocop:enable Rails/SkipsModelValidations
    end

    # Public: Finds all the InitiativeTypeScopes that are eligible to be voted by a user.
    # Usually this is only the `scoped_type` but voting on children of the scoped type is
    # enabled we have to filter all the available scopes in the initiative type to select
    # the ones that are a descendant of the initiative type.
    #
    # Returns an Array of Decidim::InitiativesScopeType.
    def votable_initiative_type_scopes
      return Array(scoped_type) unless type.child_scope_threshold_enabled?

      initiative_type_scopes.select do |initiative_type_scope|
        initiative_type_scope.scope.present? && (scoped_type.global_scope? || scoped_type.scope.ancestor_of?(initiative_type_scope.scope))
      end.prepend(scoped_type).uniq
    end

     private

    # Private: This is just an alias because the naming on InitiativeTypeScope
    # is very confusing. The `scopes` method doesn't return Decidim::Scope but
    # Decidim::InitiativeTypeScopes.
    #
    # ¯\_(ツ)_/¯
    #
    # Returns an Array of Decidim::InitiativesScopeType.
    def initiative_type_scopes
      type.scopes
    end
  end

  class_methods do
    def user_collection(author)
      return unless author.is_a?(Decidim::User)
      where(decidim_author_id: author.id)
    end

    def export_serializer
      Decidim::Initiatives::InitiativeSerializer
    end

    def data_portability_images(user)
    end
  end
end

Decidim::Initiative.send(:include, InitiativeExtend)
