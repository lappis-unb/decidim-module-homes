# frozen_string_literal: true

require "spec_helper"

module Decidim::Homes
  describe DataSerializer do
    let!(:home) { create(:home) }
    let(:serializer) { described_class.new(home.component) }

    describe "#serialize" do
      subject { serializer.serialize }

      it "serializes the home data" do
        expect(subject).to eq({ body: home.body })
      end
    end
  end
end
