require "rails_helper"

describe Segment do
  it "starts" do
    Timecop.freeze do
      s = described_class.create
      s.start
      expect(s.start_at).to eq(DateTime.now)
    end
  end

  it "counts end" do
    Timecop.freeze do
      s = described_class.create(duration: 5)
      s.start
      s.count_end
      expect(s.end_at).to eq(DateTime.now+s.duration.minutes)
    end
  end

  it "can have pauses" do
    s = described_class.create
    s.pause
    expect(s.pauses.count).to eq(1)
  end

  it "resume the pauses" do
    s = described_class.create
    s.pause
    s.resume
    expect(s.pauses.first.end_at).not_to be_nil
  end

  it "count full duration with pauses" do
    Timecop.freeze do
      s = described_class.create(duration:5)
      s.pause
      Timecop.travel(DateTime.now+5.seconds)
      s.resume
      expect(s.full_duration).to eq(10)
    end

  end
end
