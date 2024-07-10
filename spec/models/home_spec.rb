# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Homes
    describe Home do
      subject { home }

      let(:home) { create(:home, meetings_map: true) }

      include_examples "has component"
      include_examples "resourceable"

      it { is_expected.to be_valid }
      it { is_expected.to be_versioned }

      context "without a component" do
        let(:home) { build :home, component: nil }

        it { is_expected.not_to be_valid }
      end

      context "without a valid component" do
        let(:home) { build :home, component: build(:component, manifest_name: "proposals") }

        it { is_expected.not_to be_valid }
      end

      it "has an associated component" do
        expect(home.component).to be_a(Decidim::Component)
      end

      it "has meetings_map set to true" do
        expect(home.meetings_map).to be true
      end

      context "when meetings_map is false" do
        let(:home) { create(:home, meetings_map: false) }

        it "has meetings_map set to false" do
          expect(home.meetings_map).to be false
        end
      end
    end
  end
end
