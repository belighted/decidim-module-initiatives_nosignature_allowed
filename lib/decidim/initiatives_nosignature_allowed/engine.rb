# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module InitiativesNosignatureAllowed
    # This is the engine that runs on the public interface of initiatives_nosignature_allowed.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::InitiativesNosignatureAllowed

      routes do
        # Add engine routes here
        # resources :initiatives_nosignature_allowed
        # root to: "initiatives_nosignature_allowed#index"
      end

      initializer "decidim_initiatives_nosignature_allowed.assets" do |app|
        app.config.assets.precompile += %w[decidim_initiatives_nosignature_allowed_manifest.js decidim_initiatives_nosignature_allowed_manifest.css]
      end
    end
  end
end
