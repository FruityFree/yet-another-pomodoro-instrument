class Pause < ActiveRecord::Base
  belongs_to :segment

  after_create(:start)

  def start
    update_attributes(start_at: DateTime.now)
  end

  def resume
    update_attributes(end_at: DateTime.now)
  end

  def duration #in seconds
    if start_at.nil?
      0
    elsif end_at.nil?
      DateTime.now.to_i - start_at.to_i
    else
      end_at.to_i - start_at.to_i
    end
  end

end
