# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module InitiativesNoSignatureAllowed
    # This is the engine that runs on the public interface of initiatives_no_signature_allowed.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::InitiativesNoSignatureAllowed

      routes do
        # Add engine routes here
        # resources :initiatives_no_signature_allowed
        # root to: "initiatives_no_signature_allowed#index"
      end

      initializer "decidim_initiatives_no_signature_allowed.assets" do |app|
        app.config.assets.precompile += %w[decidim_initiatives_no_signature_allowed_manifest.js decidim_initiatives_no_signature_allowed_manifest.css]
      end
    end
  end
end
