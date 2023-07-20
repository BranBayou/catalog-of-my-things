require_relative '../author'

describe Author do
  let(:first_name) { 'John' }
  let(:last_name) { 'Doe' }
  let(:item) { double('item', author: nil) }
  subject { Author.new(first_name, last_name) }
  describe '#initialize' do
    it 'assigns a random id to the author' do
      expect(subject.id).to be_an(Integer)
    end
    it 'sets the first name of the author' do
      expect(subject.first_name).to eq(first_name)
    end
    it 'sets the last name of the author' do
      expect(subject.last_name).to eq(last_name)
    end
    it 'initializes an empty array for items' do
      expect(subject.items).to be_empty
    end
  end
  describe '#add_item' do
    it 'sets the author of the item to itself' do
      expect(item).to receive(:author=).with(subject)
      subject.add_item(item)
    end
  end
end
