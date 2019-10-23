require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'validations' do
    subject { create :document }

    it { is_expected.to validate_presence_of(:name) }
  end
end
