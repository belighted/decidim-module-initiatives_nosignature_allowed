# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/initiatives_no_signature_allowed/version"

Gem::Specification.new do |s|
  s.version = Decidim::InitiativesNoSignatureAllowed.version
  s.authors = ["Armand Fardeau"]
  s.email = ["fardeauarmand@gmail.com"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/decidim/decidim-module-initiatives_no_signature_allowed"
  s.required_ruby_version = ">= 2.5"

  s.name = "decidim-initiatives_no_signature_allowed"
  s.summary = "A decidim initiatives_no_signature_allowed module"
  s.description = "Allow a user to create an initiative that do not collect signatures.."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::InitiativesNoSignatureAllowed.version
  s.add_dependency "decidim-initiatives", Decidim::InitiativesNoSignatureAllowed.version
end
