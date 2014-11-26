require 'samples/inheritance_sample'

RSpec.describe Renewable do
  context 'used via inheritance' do
    it 'initializes to a frozen object' do
      expect(PersonA.new(birth_date: '1972-06-13').frozen?).to eq(true)
    end

    it 'assigns all attributes' do
      person = PersonA.new(name: 'John',
                          birth_date: '1972-06-13',
                          hair_color: 'Brown')

      expect(person.instance_variable_get(:@name)).to eq('John')
      expect(person.instance_variable_get(:@birth_date)).to eq('1972-06-13')
      expect(person.instance_variable_get(:@hair_color)).to eq('Brown')
    end

    it 'runs process_arguments callback' do
      expect {
        PersonA.new({}, {raise_process_arguments: true})
      }.to raise_error(ArgumentError, 'entered process_arguments with raise option')
    end

    it 'runs before_freeze callback' do
      expect {
        PersonA.new({}, {raise_before_freeze: true})
      }.to raise_error(ArgumentError, 'entered before_freeze with raise option')
    end

    it 'runs after_freeze callback' do
      expect {
        PersonA.new({}, {raise_after_freeze: true})
      }.to raise_error(ArgumentError, 'entered after_freeze with raise option')
    end
  end
end