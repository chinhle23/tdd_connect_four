require_relative '../lib/connect_four'

describe ConnectFour do
  subject(:game) { described_class.new }

  describe '#display' do
    context 'when game just started' do
      it 'displays an empty board' do
        expect(game).to receive(:puts).with(
          "\n☐ ☐ ☐ ☐ ☐ ☐ ☐\n☐ ☐ ☐ ☐ ☐ ☐ ☐\n☐ ☐ ☐ ☐ ☐ ☐ ☐\n☐ ☐ ☐ ☐ ☐ ☐ ☐\n☐ ☐ ☐ ☐ ☐ ☐ ☐\n☐ ☐ ☐ ☐ ☐ ☐ ☐"
        )
        game.display
      end
    end

    context 'when game is in play' do
      subject(:game) {
        described_class.new(
          [
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☒', '☑']
          ]
        )
      }

      it 'displays board correctly' do
        expect(game).to receive(:puts).with(
          "\n☐ ☐ ☐ ☐ ☐ ☐ ☐\n☐ ☐ ☐ ☐ ☐ ☐ ☐\n☐ ☐ ☐ ☐ ☐ ☐ ☐\n☐ ☐ ☐ ☐ ☐ ☐ ☐\n☐ ☐ ☐ ☐ ☐ ☐ ☐\n☐ ☐ ☐ ☐ ☐ ☒ ☑"
        )
        game.display
      end
    end
  end

  describe '#drop_piece' do
    context 'when column is empty' do
      it 'drops piece to the bottom' do
        expect { game.drop_piece(1, '☑') }.to change { game.instance_variable_get(:@board)[5][0] }.to('☑')
      end
    end

    context 'when column is not empty' do
      subject(:game) {
        described_class.new(
          [
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☒', '☐', '☐', '☐', '☐', '☒', '☑']
          ]
        )
      }

      it 'drops piece to the lowest empty spot' do
        expect { game.drop_piece(1, '☑') }.to change { game.instance_variable_get(:@board)[4][0] }.to('☑')
      end
    end
  end
end
