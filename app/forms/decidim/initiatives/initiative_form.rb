# frozen_string_literal: true

module Decidim
  module Initiatives
    # A form object used to collect the data for a new initiative.
    class InitiativeForm < Form
      include TranslatableAttributes

      mimic :initiative

      attribute :title, String
      attribute :description, String
      attribute :type_id, Integer
      attribute :scope_id, Integer
      attribute :decidim_user_group_id, Integer
      attribute :signature_type, String
      attribute :signature_end_date, Date
      attribute :state, String
      attribute :no_signature, Boolean
      attribute :attachment, AttachmentForm

      validates :title, :description, presence: true
      validates :title, length: { maximum: 150 }
      validates :signature_type, presence: true
      validates :type_id, presence: true
      validate :scope_exists
      validates :signature_end_date, date: { after: Date.current }, if: lambda { |form|
        type.custom_signature_end_date_enabled? && form.signature_end_date.present?
      }
      validate :check_no_signature
      validate :notify_missing_attachment_if_errored
      validate :trigger_attachment_errors

      def map_model(model)
        self.type_id = model.type.id
        self.scope_id = model.scope&.id
      end

      def check_no_signature
        return true if no_signature.blank?

        errors.add(:no_signature, I18n.t("activemodel.errors.models.initiatives.no_signature_allowed")) unless type.no_signature_allowed?
      end

      def signature_type_updatable?
        state == "created" || state.nil?
      end

      def scope_id
        return nil if initiative_type.only_global_scope_enabled?

        super.presence
      end

      def initiative_type
        @initiative_type ||= InitiativesType.find(type_id)
      end

      def available_scopes
        @available_scopes ||= if initiative_type.only_global_scope_enabled?
                                initiative_type.scopes.where(scope: nil)
                              else
                                initiative_type.scopes
                              end
      end

      def scope
        @scope ||= Scope.find(scope_id) if scope_id.present?
      end

      private

      def scope_exists
        return if scope_id.blank?

        errors.add(:scope_id, :invalid) unless InitiativesTypeScope.where(type: initiative_type, scope: scope).exists?
      end

      def type
        @type ||= Decidim::InitiativesType.find(type_id)
      end
      
      # This method will add an error to the `attachment` field only if there's
      # any error in any other field. This is needed because when the form has
      # an error, the attachment is lost, so we need a way to inform the user of
      # this problem.
      def notify_missing_attachment_if_errored
        return if attachment.blank?

        errors.add(:attachment, :needs_to_be_reattached) if errors.any?
      end

      def trigger_attachment_errors
        return if attachment.blank?
        return if attachment.valid?

        attachment.errors.each { |error| errors.add(:attachment, error) }

        attachment = Attachment.new(file: attachment.try(:file))

        errors.add(:attachment, :file) if !attachment.save && attachment.errors.has_key?(:file)
      end
    end
  end
end
