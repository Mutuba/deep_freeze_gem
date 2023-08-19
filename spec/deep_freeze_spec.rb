# frozen_string_literal: true

RSpec.describe DeepFreeze do
  include DeepFreeze

  it 'freezes strings' do
    string = 'Hello, World!'
    deep_freeze(string)
    expect(string.frozen?).to be true
  end

  it 'freezes numbers' do
    number = 42
    deep_freeze(number)
    expect(number.frozen?).to be true
  end

  it 'freezes symbols' do
    symbol = :my_symbol
    deep_freeze(symbol)
    expect(symbol.frozen?).to be true
  end

  it 'freezes nil' do
    nil_obj = nil
    deep_freeze(nil_obj)
    expect(nil_obj.frozen?).to be true
  end

  it 'freezes true booleans' do
    true_obj = true
    deep_freeze(true_obj)
    expect(true_obj.frozen?).to be true
  end

  it 'freezes false booleans' do
    false_obj = false
    deep_freeze(false_obj)
    expect(false_obj.frozen?).to be true
  end

  it 'deep freezes arrays' do
    array = ['Hello', 'World!', [1, 2, 3]]
    deep_freeze(array)
    expect(array.frozen?).to be true
    expect(array.all?(&:frozen?)).to be true
    expect(array.last.all?(&:frozen?)).to be true
  end

  it 'deep freezes hashes' do
    hash = { a: 'Hello', b: 'World!', c: { d: 42 } }
    deep_freeze(hash)
    expect(hash.frozen?).to be true
    expect(hash.keys.all?(&:frozen?)).to be true
    expect(hash.values.all?(&:frozen?)).to be true
    expect(hash[:c].keys.all?(&:frozen?)).to be true
  end

  it 'raises an error when trying to freeze unsupported types' do
    unsupported_obj = Object.new
    expect { deep_freeze(unsupported_obj) }.to raise_error(RuntimeError)
  end
end
