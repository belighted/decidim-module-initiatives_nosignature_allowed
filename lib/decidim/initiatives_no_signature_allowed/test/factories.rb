# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  factory :initiatives_no_signature_allowed_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :initiatives_no_signature_allowed).i18n_name }
    manifest_name :initiatives_no_signature_allowed
    participatory_space { create(:participatory_process, :with_steps) }
  end

  # Add engine factories here
end
