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

  describe '#read_input' do
    before do
      valid_input = '3'
      allow(game).to receive(:gets).and_return(valid_input)
    end

    context 'when waiting for column input' do
      it 'receives input with gets' do
        expect(game).to receive(:gets)
        game.read_input
      end

      it 'calls #drop_piece with column input' do
        expect(game).to receive(:drop_piece).with(3, '☑')
        game.read_input
      end
    end

    context 'when it is the first turn' do
      it 'calls #drop_piece with ☑' do
        expect(game).to receive(:drop_piece).with(3, '☑')
        game.read_input
      end
    end

    context 'when it is the second turn' do
      it 'calls #drop_piece with ☒' do
        game.read_input
        expect(game).to receive(:drop_piece).with(3, '☒')
        game.read_input
      end
    end

    context 'when user inputs exit' do
      before do
        allow(game).to receive(:gets).and_return('exit')
      end

      it 'exits the game' do
        expect(game).to receive(:exit)
        game.read_input
      end
    end

    context 'when user inputs q' do
      before do
        allow(game).to receive(:gets).and_return('q')
      end

      it 'exits the game' do
        expect(game).to receive(:exit)
        game.read_input
      end
    end

    describe 'invalid inputs' do
      before do
        allow(game).to receive(:gets).and_return('peanut')
      end

      it 'does not call #drop_piece' do
        expect(game).not_to receive(:drop_piece)
        game.read_input
      end

      context 'when user inputs letter' do
        before do
          allow(game).to receive(:gets).and_return('a')
        end

        it 'displays error message' do
          expect(game).to receive(:puts).with('Invalid input: Please input a number between 1 and 7')
          game.read_input
        end
      end

      context 'when user inputs a large number' do
        before do
          allow(game).to receive(:gets).and_return('25')
        end

        it 'displays error message' do
          expect(game).to receive(:puts).with('Invalid input: Please input a number between 1 and 7')
          game.read_input
        end
      end

      context 'when user inputs zero' do
        before do
          allow(game).to receive(:gets).and_return('0')
        end

        it 'displays error message' do
          expect(game).to receive(:puts).with('Invalid input: Please input a number between 1 and 7')
          game.read_input
        end
      end

      context 'when user inputs a negative number' do
        before do
          allow(game).to receive(:gets).and_return('-1')
        end

        it 'displays error message' do
          expect(game).to receive(:puts).with('Invalid input: Please input a number between 1 and 7')
          game.read_input
        end
      end
    end
  end

  describe '#horizontal_win?' do
    context 'when user places 4 consective matching pieces in row 1' do
      subject(:game) {
        described_class.new(
          [
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☑'],
            ['☒', '☒', '☒', '☒', '☑', '☑', '☑']
          ]
        )
      }

      it 'returns a horizontal win' do
        expect(game.horizontal_win?('☒')).to be true
      end
    end

    context 'when user places 4 consective matching pieces in row 2' do
      subject(:game) {
        described_class.new(
          [
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☒', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☒', '☒', '☐', '☑', '☑', '☑', '☑'],
            ['☒', '☒', '☐', '☒', '☑', '☑', '☑']
          ]
        )
      }

      it 'returns a horizontal win' do
        expect(game.horizontal_win?('☑')).to be true
      end
    end

    context 'when user places 3 consective matching pieces in row 2' do
      subject(:game) {
        described_class.new(
          [
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☒', '☐', '☐', '☐', '☐', '☐', '☑'],
            ['☒', '☒', '☐', '☒', '☑', '☑', '☑'],
            ['☒', '☒', '☐', '☒', '☑', '☑', '☑']
          ]
        )
      }

      it 'does not return a horizontal win' do
        expect(game.horizontal_win?('☑')).to be false
      end
    end
  end

  describe '#vertical_win?' do
    context 'when user places 4 consective matching pieces in column 1' do
      subject(:game) {
        described_class.new(
          [
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☒', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☒', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☒', '☐', '☐', '☐', '☐', '☐', '☑'],
            ['☒', '☐', '☐', '☐', '☑', '☑', '☑']
          ]
        )
      }

      it 'returns a vertical win' do
        expect(game.vertical_win?('☒')).to be true
      end
    end

    context 'when user places 4 consective matching pieces in column 2' do
      subject(:game) {
        described_class.new(
          [
            ['☐', '☑', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☑', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☑', '☐', '☐', '☐', '☐', '☐'],
            ['☒', '☑', '☐', '☐', '☐', '☐', '☐'],
            ['☒', '☒', '☐', '☒', '☒', '☒', '☑'],
            ['☒', '☒', '☐', '☒', '☑', '☑', '☑']
          ]
        )
      }

      it 'returns a vertical win' do
        expect(game.vertical_win?('☑')).to be true
      end
    end

    context 'when user places 3 consective matching pieces in column 2' do
      subject(:game) {
        described_class.new(
          [
            ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☑', '☐', '☐', '☐', '☐', '☐'],
            ['☐', '☑', '☐', '☐', '☐', '☐', '☐'],
            ['☒', '☑', '☐', '☐', '☐', '☐', '☑'],
            ['☒', '☒', '☐', '☒', '☒', '☒', '☑'],
            ['☒', '☒', '☐', '☒', '☑', '☑', '☑']
          ]
        )
      }

      it 'does not return a vertical win' do
        expect(game.vertical_win?('☑')).to be false
      end
    end
  end
end
