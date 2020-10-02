# frozen_string_literal: true

module Decidim
  module InitiativesNoSignatureAllowed
    # This is the engine that runs on the public interface of `InitiativesNoSignatureAllowed`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::InitiativesNoSignatureAllowed::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      initializer "decidim_initiatives_no_signature_allowed extends" do
        Dir.glob("#{Decidim::InitiativesNoSignatureAllowed::Engine.root}/lib/extends/initiatives_no_signature_allowed/**/*.rb").each do |override|
          require_dependency override
        end
      end

      routes do
        # Add admin engine routes here
        # resources :initiatives_no_signature_allowed do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "initiatives_no_signature_allowed#index"
      end

      initializer "admin_decidim_initiatives_no_signature_allowed.assets" do |app|
        app.config.assets.precompile += %w(admin_decidim_initiatives_no_signature_allowed_manifest.js)
      end

      def load_seed
        nil
      end
    end
  end
end
