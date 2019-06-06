require './lib/separator.rb'

describe Separator do

  it 'should return empty hash if string is empty' do
    separator = Separator.new("")
    expect(separator.parse).to eq({})
  end

  it 'should have an nil value if in string is not value' do
    separator = Separator.new("a => ")
    expect(separator.parse).to eq({ 'a' => nil })
  end

  it 'should return keys with nill value' do
    separator = Separator.new("a => \nb => \nc =>")
    expect(separator.parse).to eq({ 'a' => nil, 'b' => nil, 'c' => nil })
  end

  it 'should return correct hash where a and f keys having nil value and rest are dependent jobs' do
    separator = Separator.new("a => \nb => c \nc => f \nd => a \ne => b \nf => ")
    expect(separator.parse).to eq({ 'a' => nil, 'b' => 'c', 'c' => 'f', 'd' => 'a', 'e' => 'b', 'f' => nil })
  end
end
