class Separator
  def initialize(input)
    @input = input
    @colection = {}
  end

  def parse
    @input.split(/\r?\n/).each do |dependency|
      jobs = dependency.gsub(/\s+/, '').split('=>')
      jobs[1] ||= nil
      @colection[jobs[0]] = jobs[1]
    end

    @colection
  end
end
