require "rails_helper"

describe PomodoroBlock do
  it "creates segments" do
    pb = described_class.create
    expect(pb.segments.count).to eq(8)
  end

  it "recounts segments" do

  end
end
