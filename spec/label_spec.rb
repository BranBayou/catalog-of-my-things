require_relative '../label'

RSpec.describe Label do
  let(:label_id) { 1 }
  let(:label_name) { 'Sample Label' }
  let(:label_color) { 'blue' }

  subject(:label) { Label.new(label_id, label_name, label_color) }

  describe '#initialize' do
    it 'initializes a new Label object' do
      expect(label).to be_an_instance_of(Label)
    end

    it 'sets the correct attributes' do
      expect(label.id).to eq(label_id)
      expect(label.name).to eq(label_name)
      expect(label.color).to eq(label_color)
      expect(label.items).to eq([])
    end
  end

  describe '#add_item' do
    let(:item) { double('item') }

    it 'sets the label of the added item' do
      expect(item).to receive(:label=).with(label)
      label.add_item(item)
    end
  end

  describe '#remove_item' do
    let(:item) { double('item') }

    before do
      label.add_item(item)
    end
  end
end
