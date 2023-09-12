require 'rails_helper'

RSpec.describe Car do
  describe 'associations' do
    let(:car) { create(:car) }

    it 'embeds one version' do
      expect(car).to embed_one(:version)
    end
  end
end
