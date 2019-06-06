require './lib/job.rb'

describe Job do

  context 'valid inputs' do
    it 'should return an empty sequence' do
      job = Job.new("")
      expect(job.solution).to eq("")
    end

    it 'should be a single job' do
      job = Job.new("a => ")
      expect(job.solution).to eq("a")
    end

    it 'should be a jobs sequence abc in no significant order' do
      job = Job.new("a => \nb => \nc =>")
      expect(job.solution).to eq("a, b, c")
    end

    it 'should be a sequence that positions c before b, containing all three jobs abc' do
      job = Job.new("a => \nb => c \nc =>")
      expect(job.solution).to eq("a, c, b")
    end

    it 'should be a sequence that positions f before c, c before b, b before e and a before d' do
      job = Job.new("a => \nb => c \nc => f \nd => a \ne => b \nf => ")
      expect(job.solution).to eq("a, f, c, b, d, e")
    end
  end

  context 'invalid inputs' do
    it "should be an error: jobs can’t depend on themselves." do
      job = Job.new("a => \nb => \nc => c")
      expect(job.solution).to match('ERROR! jobs can’t depend on themselves!')
    end

    it "should be an error: jobs can’t have circular dependencies." do
      job = Job.new("a => \nb => c \nc => f \nd => a \ne => \nf => b")
      expect(job.solution).to match('ERROR! jobs can’t have circular dependencies!')
    end
  end

end
