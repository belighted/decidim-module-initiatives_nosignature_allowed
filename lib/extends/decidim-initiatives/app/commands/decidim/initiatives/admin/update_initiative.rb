# frozen_string_literal: true
require "active_support/concern"

module AdminUpdateInitiativeExtend
  extend ActiveSupport::Concern

  included do
    def attributes
      attrs = {
        title: form.title,
        description: form.description,
        hashtag: form.hashtag
      }

      if form.signature_type_updatable?
        attrs[:signature_type] = form.signature_type
        attrs[:scoped_type_id] = form.scoped_type_id if form.scoped_type_id
      end

      if current_user.admin?
        attrs[:signature_start_date] = form.signature_start_date
        attrs[:signature_end_date] = form.signature_end_date
        if form.offline_votes
          attrs[:offline_votes] = form.offline_votes.blank? ? { "total": 0 } : form.offline_votes
        end
        attrs[:state] = form.state if form.state

        if initiative.published?
          @notify_extended = true if form.signature_end_date != initiative.signature_end_date &&
            form.signature_end_date > initiative.signature_end_date
        end
      end

      attrs
    end
  end
end

Decidim::Initiatives::Admin::UpdateInitiative.send(:include, AdminUpdateInitiativeExtend)
