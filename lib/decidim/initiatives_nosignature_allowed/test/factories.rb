# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  factory :initiatives_nosignature_allowed_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :initiatives_nosignature_allowed).i18n_name }
    manifest_name :initiatives_nosignature_allowed
    participatory_space { create(:participatory_process, :with_steps) }
  end

  # Add engine factories here
end
