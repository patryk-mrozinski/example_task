require_relative './separator'

class Job
  def initialize(input)
    @colection = Separator.new(input).parse
    @final_sequence = []
  end

  def queue
    @colection.each do |key, value|
      if self_depending?(key, value)
        return 'ERROR! jobs can’t depend on themselves!'
      end

      next if @final_sequence.include?(key)

      if not_depending_on_any_jobs?(value)
        @final_sequence << key
        next
      end

      if dependent_job_already_done?(value)
        @final_sequence << key
        next
      end

      sequence = [key]
      loop do
        new_key = @colection[key]

        if not_circulary_dependent?(sequence, new_key)
          return 'ERROR! jobs can’t have circular dependencies!'
        end

        sequence << new_key

        if @colection[new_key].nil?
          break
        else
          key = new_key
        end
      end
      @final_sequence.push(*sequence.reverse)
    end

    @final_sequence.join(', ')
  end

  private

  def self_depending?(key, value)
    value == key
  end

  def not_depending_on_any_jobs?(value)
    value.nil?
  end

  def dependent_job_already_done?(value)
    @final_sequence.include?(value)
  end

  def not_circulary_dependent?(sequence, new_key)
    sequence.include?(new_key)
  end
end
