require_relative '../music'

describe MusicAlbum do
  let(:publish_date) { Date.new(2021, 1, 1) }
  let(:archived) { false }
  let(:on_spotify) { true }
  subject { MusicAlbum.new(publish_date, archived, on_spotify) }
  describe '#can_be_archived?' do
    context 'when the album is not on Spotify' do
      let(:on_spotify) { false }
      it 'returns false' do
        expect(subject.can_be_archived?).to be false
      end
    end
    context 'when the album is archived' do
      let(:archived) { true }
      it 'returns false' do
        expect(subject.can_be_archived?).to be false
      end
    end
    context 'when the album is not published, archived, and not on Spotify' do
      let(:publish_date) { Date.new(2022, 1, 1) }
      let(:archived) { true }
      let(:on_spotify) { false }
      it 'returns false' do
        expect(subject.can_be_archived?).to be false
      end
    end
  end
end
