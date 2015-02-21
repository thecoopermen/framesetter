require 'rails_helper'

RSpec.describe Comp, type: :model do

  describe '#landscape?' do
    it 'is false when a comp is portrait' do
      expect(create(:comp, portrait: true)).to_not be_landscape
    end

    it 'is true when a comp is not portrait' do
      expect(create(:comp, portrait: false)).to be_landscape
    end
  end
end
