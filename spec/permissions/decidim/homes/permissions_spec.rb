# frozen_string_literal: true

require "spec_helper"

describe Decidim::Homes::Permissions do
  subject { described_class.new(user, permission_action, context).permissions.allowed? }

  let(:user) { build :user }
  let(:space_allows) { true }
  let(:context) do
    {
      current_component: home_component
    }
  end
  let(:home_component) { create :home_component }
  let(:permission_action) { Decidim::PermissionAction.new(**action) }

  context "when updating a home" do
    let(:action) do
      { scope: :admin, action: :update, subject: :home }
    end

    it { is_expected.to be true }
  end

  context "when any other action" do
    let(:action) do
      { scope: :admin, action: :foo, subject: :bar }
    end

    it_behaves_like "permission is not set"
  end
end
