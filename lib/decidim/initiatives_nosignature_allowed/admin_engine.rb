# frozen_string_literal: true

module Decidim
  module InitiativesNosignatureAllowed
    # This is the engine that runs on the public interface of `InitiativesNosignatureAllowed`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::InitiativesNosignatureAllowed::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :initiatives_nosignature_allowed do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "initiatives_nosignature_allowed#index"
      end

      def load_seed
        nil
      end
    end
  end
end
