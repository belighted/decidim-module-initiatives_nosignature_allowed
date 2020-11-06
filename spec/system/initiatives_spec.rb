# frozen_string_literal: true

require "spec_helper"
require "decidim/core/test/shared_examples/has_contextual_help"

describe "Initiatives", type: :system do
  let(:organization) { create(:organization) }
  let(:base_initiative) do
    create(:initiative, organization: organization)
  end

  before do
    switch_to_host(organization.host)
  end

  context "when there are some published initiatives" do
    let!(:initiative) { base_initiative }
    let!(:unpublished_initiative) do
      create(:initiative, :created, organization: organization)
    end

    it_behaves_like "shows contextual help" do
      let(:index_path) { decidim_initiatives.initiatives_path }
      let(:manifest_name) { :initiatives }
    end

    it_behaves_like "editable content for admins" do
      let(:target_path) { decidim_initiatives.initiatives_path }
    end

    context "when requesting the initiatives path" do
      before do
        visit decidim_initiatives.initiatives_path
      end

      context "when accessing from the homepage" do
        it "the menu link is shown" do
          visit decidim.root_path

          within ".main-nav" do
            expect(page).to have_content("Initiatives")
            click_link "Initiatives"
          end

          expect(page).to have_current_path(decidim_initiatives.initiatives_path)
        end
      end

      it "lists all the initiatives" do
        within "#initiatives-count" do
          expect(page).to have_content("1")
        end

        within "#initiatives" do
          expect(page).to have_content(translated(initiative.title, locale: :en))
          expect(page).to have_content(initiative.author_name, count: 1)
          expect(page).not_to have_content(translated(unpublished_initiative.title, locale: :en))
        end
      end

      it "links to the individual initiative page" do
        click_link(translated(initiative.title, locale: :en))
        expect(page).to have_current_path(decidim_initiatives.initiative_path(initiative))
      end

      it "displays the filter initiative type filter" do
        within ".new_filter[action='/initiatives']" do
          expect(page).to have_content(/Type/i)
        end
      end

      context "when there is a unique initiative type" do
        let!(:unpublished_initiative) { nil }

        it "doesn't display the initiative type filter" do
          within ".new_filter[action='/initiatives']" do
            expect(page).not_to have_content(/Type/i)
          end
        end
      end

      context "when no signature mode is activated" do
        let!(:initiative) { create(:initiative, :published, :no_signature, organization: organization) }

        it "doesn't displays signature count" do
          expect(page).not_to have_content("#{initiative.initiative_votes_count}/#{initiative.supports_required}")
          expect(page).not_to have_css("#initiative_#{initiative.id} .card__support__data")
        end

        it "doesn't displays sign button" do
          expect(page).not_to have_content("CHECK IT OUT AND SIGN")
          expect(page).to have_content("CHECK IT OUT")
        end
      end
    end
  end
end
