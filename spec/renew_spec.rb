require 'samples/inheritance_sample'

RSpec.describe Renewable do
  describe '#renew' do
    let(:subject) { InheritedPerson.new(attributes) }
    let(:attributes) { {
        name: 'John',
        birth_date: '1973-06-15'
    } }

    it 'returns a new object' do
      new_object = subject.renew
      expect(new_object.__id__).not_to eq(subject.__id__)
    end

    it 'changes attributes of new object' do
      new_object = subject.renew(name: 'Jack')
      name = new_object.instance_variable_get(:@name)
      expect(name).to eq('Jack')
    end

    it 'changes options of new object' do
      new_object = subject.renew({}, example: 'test')
      options = new_object.instance_variable_get(:@renewable_options)
      expect(options[:example]).to eq('test')
    end
  end
end