require 'date'
require_relative '../item'
RSpec.describe Item do
  let(:publish_date) { Date.new(2010, 1, 1) }
  let(:archived) { false }
  let(:item) { Item.new(publish_date, archived) }
  describe '#initialize' do
    it 'sets the publish date' do
      expect(item.publish_date).to eq(publish_date)
    end
    it 'sets the archived status' do
      expect(item.archived).to eq(archived)
    end
    it 'generates a random id' do
      expect(item.id).to be_a(Integer)
    end
    it 'sets the label to nil' do
      expect(item.label).to be_nil
    end
    it 'sets the genre to nil' do
      expect(item.genre).to be_nil
    end
    it 'sets the author to nil' do
      expect(item.author).to be_nil
    end
  end
  describe '#move_to_archive' do
    context 'when the item can be archived' do
      it 'sets the archived status to true' do
        item.move_to_archive
        expect(item.archived).to be true
      end
    end
    context 'when the item cannot be archived' do
      let(:publish_date) { Date.today }
      it 'does not change the archived status' do
        item.move_to_archive
        expect(item.archived).to be false
      end
    end
  end
end
