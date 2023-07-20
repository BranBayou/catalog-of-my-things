require_relative '../game'

RSpec.describe Game do
  let(:publish_date) { Date.new(2020, 1, 1) }
  let(:multiplayer) { true }
  let(:last_played_at) { Date.new(2021, 1, 1) }
  let(:archived) { false }

  subject(:game) { Game.new(publish_date, multiplayer, last_played_at, archived: archived) }

  describe '#initialize' do
    it 'initializes a new Game object' do
      expect(game).to be_an_instance_of(Game)
    end

    it 'sets the correct attributes' do
      expect(game.publish_date).to eq(publish_date)
      expect(game.multiplayer).to eq(multiplayer)
      expect(game.last_played_at).to eq(last_played_at)
      expect(game.archived).to eq(archived)
    end
  end

  describe '#can_be_archived?' do
    context 'when the game is not archived and last played over 2 years ago' do
      let(:archived) { false }
      let(:last_played_at) { Date.today - 2.years - 1.day }
    end

    context 'when the game is not archived and last played less than 2 years ago' do
      let(:archived) { false }
      let(:last_played_at) { Date.today - 1.year }
    end

    context 'when the game is archived' do
      let(:archived) { true }
      let(:last_played_at) { Date.today - 3.years }

    end
  end
end
