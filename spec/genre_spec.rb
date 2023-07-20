require_relative '../genre'

describe Genre do
  let(:genre_name) { 'Rock' }
  subject { Genre.new(genre_name) }
  describe '#initialize' do
    it 'assigns a random id to the genre' do
      expect(subject.id).to be_an(Integer)
    end
    it 'sets the genre name' do
      expect(subject.name).to eq(genre_name)
    end
    it 'initializes an empty array for items' do
      expect(subject.items).to be_empty
    end
  end
end
