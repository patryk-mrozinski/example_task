class Separator
  def initialize(input)
    @input = input
  end

  def parse
    arr = @input.split(/\r?\n/)

    hash = {}
    arr.each do |item|
      splited_item = item.gsub(/\s+/, '').split('=>')
      splited_item[1] ||= nil
      hash[splited_item[0]] = splited_item[1]
    end

    hash
  end
end
