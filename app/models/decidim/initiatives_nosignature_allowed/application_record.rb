# frozen_string_literal: true

module Decidim
  module InitiativesNosignatureAllowed
    # Abstract class from which all models in this engine inherit.
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
