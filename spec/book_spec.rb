require_relative '../book'
 RSpec.describe Book do
  let(:author) { 'John Doe' }
  let(:publish_date) { Date.new(2023, 1, 1) }
  let(:publisher) { 'Example Publisher' }
  let(:cover_state) { 'Good' }
  let(:label) { 'Fiction' }
   subject(:book) { Book.new(author, publish_date, publisher, cover_state, label: label) }
   describe '#initialize' do
    it 'initializes a new Book object' do
      expect(book).to be_an_instance_of(Book)
    end
     it 'sets the correct attributes' do
      expect(book.author).to eq(author)
      expect(book.publish_date).to eq(publish_date)
      expect(book.publisher).to eq(publisher)
      expect(book.cover_state).to eq(cover_state)
      expect(book.label).to eq(label)
    end
  end
   describe '#can_be_archived?' do
    context 'when the cover state is good' do
      let(:cover_state) { 'Good' }
       it 'returns false' do
        expect(book.can_be_archived?).to be_falsey
      end
    end
     context 'when the cover state is bad' do
      let(:cover_state) { 'Bad' }
       it 'returns true' do
        expect(book.can_be_archived?).to be_truthy
      end
    end
  end
end
