require "rails_helper"

describe PomodoroBlock do
  before(:each) do
    @pb = described_class.create
  end

  it "creates segments" do
    expect(@pb.segments.count).to eq(8)
  end

  context "when pomodoro started" do
    it "recounts segments" do
      Timecop.freeze do
        @pb.start
        duration_first = @pb.segments.first.duration
        duration_second = @pb.segments.second.duration
        new_time = DateTime.now+(duration_first + duration_second+1).minutes
        Timecop.travel(new_time)
        @pb.recount_segments
        expect(@pb.segments.first.end_at).not_to be_nil
        expect(@pb.segments.second.start_at).not_to be_nil
        expect(@pb.segments.third.end_at).to be_nil
      end
    end
  end

  context "when pomodoro hasn't started" do
    it "recounts raise error" do
      expect{pb.recount_segments}.to raise_error
    end
  end
end
