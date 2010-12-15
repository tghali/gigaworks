Given 'it is now $time' do |time|
  Timecop.freeze Time.parse(time)
end

When '$time (?:has|have) passed' do |time|
  Timecop.travel future_time(time)
  Given 'delayed jobs are run'  # we use delayed jobs and have some that get scheduled in the future.
end

When 'time stands still' do
  Timecop.freeze Time.now
end