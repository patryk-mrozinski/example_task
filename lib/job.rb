require_relative './separator'

class Job
  def initialize(input)
    @hash = Separator.new(input).parse
    @final = []
  end

  def solution
    @hash.each do |key, value|

      if self_depending?(key, value)
        return 'ERROR! jobs can’t depend on themselves!'
      end

      next if @final.include?(key)

      if not_depending_on_any_jobs?(value)
        @final << key
        next
      end

      if dependent_job_already_done?(value)
        @final << key
        next
      end

      arr = [key]
      loop do
        new_key = @hash[key]

        if not_circulary_dependent?(arr, new_key)
          return 'ERROR! jobs can’t have circular dependencies!'
        end

        arr << new_key

        if @hash[new_key].nil?
          break
        else
          key = new_key
        end
      end
      @final.push(*arr.reverse)
    end
    return @final.join(', ')
  end

  private

  def self_depending?(key, value)
    value == key
  end

  def not_depending_on_any_jobs?(value)
    value.nil?
  end

  def dependent_job_already_done?(value)
    @final.include?(value)
  end

  def not_circulary_dependent?(arr, new_key)
    arr.include?(new_key)
  end
end
