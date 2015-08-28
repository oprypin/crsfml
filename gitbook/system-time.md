# Handling time

## Time in SFML

Unlike many other libraries where time is a number of milliseconds, or a decimal number of seconds, SFML doesn't impose any specific unit or type for time values. Instead it leaves this choice to the user through a flexible class: [Time]({{book.api}}/Time.html). All SFML classes and functions that manipulate time values use this class.

[Time]({{book.api}}/Time.html) represents a time period (in other words, the time that elapses between two events). It is *not* a date-time class which would represent the current year/month/day/hour/minute/second as a timestamp, it's just a value that represents a certain amount of time, and how to interpret it depends on the context where it is used.

## Converting time

A [Time]({{book.api}}/Time.html) value can be constructed from different source units: seconds, milliseconds and microseconds. There is a (non-member) function to turn each of them into a [Time]({{book.api}}/Time.html):

```ruby
t1 = SF.microseconds(10000)
t2 = SF.milliseconds(10)
t3 = SF.seconds(0.0)
```

Note that these three times are all equal.

Similarly, a [Time]({{book.api}}/Time.html) can be converted back to either seconds, milliseconds or microseconds:

```ruby
time = ...

microseconds = time.as_microseconds
milliseconds = time.as_milliseconds
seconds = time.as_seconds
```

## Playing with time values

[Time]({{book.api}}/Time.html) is just an amount of time, so it supports arithmetic operations such as addition, subtraction, comparison, etc. Times can also be negative.

```ruby
t1 = ...
t2 = t1 * 2
t3 = t1 + t2
t4 = -t3

b1 = (t1 == t2)
b2 = (t3 > t4)
```

## Measuring time

Relevant example: **[transformable]({{book.examples}}/transformable.cr)**

Now that we've seen how to manipulate time values with CrSFML, let's see how to do something that almost every program needs: measuring the time elapsed.

CrSFML has a very simple class for measuring time: [Clock]({{book.api}}/Clock.html). It only has two methods: `elapsed_time`, to retrieve the time elapsed since the clock started, and `restart`, to restart the clock.

```ruby
clock = SF::Clock.new # Starts the clock

sleep(2)

elapsed_1 = clock.elapsed_time
puts elapsed_1.as_seconds
clock.restart

sleep(3)

elapsed_2 = clock.elapsed_time
puts elapsed_2.as_seconds
```

Note that `restart` also returns the elapsed time, so that you can avoid the slight gap that would exist if you had to call `elapsed_time` explicitly before `restart`.  
Here is an example that uses the time elapsed at each iteration of the game loop to update the game logic:

```ruby
clock = SF::Clock.new

while window.open?
  elapsed = clock.restart
  update_game(elapsed)
  ...
end
```
