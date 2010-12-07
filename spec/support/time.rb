class Time

  def self.metaclass
    class << self; self; end
  end

 # useful for unit testing
 # Time.is(Time.now) do
 #   Time.now # => Tue Nov 13 19:31:46 -0500 2007
 #   sleep 2
 #   Time.now # => Tue Nov 13 19:31:46 -0500 2007
 # end
 #
 # Time.is("10/05/2006") do
 #   Time.now # => Thu Oct 05 00:00:00 -0400 2006
 #   sleep 2
 #   Time.now # => Thu Oct 05 00:00:00 -0400 2006
 # end
  def self.is(point_in_time)
    new_time = case point_in_time
               when String then Time.parse(point_in_time)
               when Time then point_in_time
               else raise ArgumentError.new("argument should be a string or time instance")
               end
    class << self
      alias old_now now
    end
    metaclass.class_eval do
      define_method :now do
        new_time
      end
    end
    yield
    class << self
      alias now old_now
      undef old_now
    end
  end

end

module TimeZoneWarp
  def pretend_zone_is(zone)
    original_zone = Time.zone
    begin
      Time.zone = zone
      yield
    ensure
      Time.zone = original_zone
    end
  end
end

include TimeZoneWarp

