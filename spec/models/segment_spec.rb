require "rails_helper"

describe Segment do
  it "starts" do
    Timecop.freeze do
      s = described_class.create
      s.start
      expect(s.start_at).to eq(DateTime.now)
    end
  end

  fit "counts end" do
    Timecop.freeze do
      s = described_class.create(duration: 5)
      s.start
      s.count_end
      expect(s.end_at).to eq(DateTime.now+s.duration.minutes)
    end
  end
end
