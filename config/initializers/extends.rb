require "extends/default_permissions"

require "extends/initiatives_no_signature_allowed/decidim-initiatives/app/forms/decidim/initiatives/admin/initiative_type_form"
require "extends/initiatives_no_signature_allowed/decidim-initiatives/app/forms/decidim/initiatives/admin/initiative_form"

require "extends/initiatives_no_signature_allowed/decidim-initiatives/app/forms/decidim/initiatives/initiative_form"

require "extends/decidim-initiatives/app/controllers/decidim/initiatives/initiatives_controller"
require "extends/decidim-initiatives/app/controllers/decidim/initiatives/initiative_votes_controller"
require "extends/decidim-initiatives/app/controllers/decidim/initiatives/initiative_signatures_controller"
require "extends/decidim-initiatives/app/commands/decidim/initiatives/admin/update_initiative"
require "extends/decidim-initiatives/app/commands/decidim/initiatives/unvote_initiative"
require "extends/decidim-initiatives/app/models/decidim/initiative"
