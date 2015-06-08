require "rails_helper"

describe Pause do
  it "init start_at when created" do
    pause = described_class.create
    expect(pause.start_at).not_to be_nil
    expect(pause.end_at).to be_nil
  end

  it "has end_at on resume" do
    pause = described_class.create
    pause.resume
    expect(pause.end_at).not_to be_nil
  end

  it "counts own duration" do
    Time.freeze do
      pause = described_class.create
      Time.travel(DateTime.now+5.seconds)
      pause.resume
      expect(pause.duration).to eq(5)
    end
  end
end
