Given /^it is now (.*)$/ do |time|
  Timecop.freeze Time.parse(time)
end

When /^(\d+) (\w+) (?:has|have) passed$/ do |time, unit|
  Timecop.travel time.to_i.send(unit.to_sym).from_now
  # Given 'delayed jobs are run'  # we use delayed jobs and have some that get scheduled in the future.
end

When /^time stands still$/ do
  Timecop.freeze Time.now
end