# Handling time

## Time in SFML

Unlike many other libraries where time is a uint32 number of milliseconds, or a float number of seconds, SFML doesn't impose any specific unit or type for time values. Instead it leaves this choice to the user through a flexible class: [Time]({{book.api}}/Time.html). All SFML classes and functions that manipulate time values use this class. 

[Time]({{book.api}}/Time.html) represents a time period (in other words, the time that elapses between two events). It is *not* a date-time class which would represent the current year/month/day/hour/minute/second as a timestamp, it's just a value that represents a certain amount of time, and how to interpret it depends on the context where it is used. 

## Converting time

A [Time]({{book.api}}/Time.html) value can be constructed from different source units: seconds, milliseconds and microseconds. There is a (non-member) function to turn each of them into a [Time]({{book.api}}/Time.html): 

```
sf::Time t1 = sf::microseconds(10000);
sf::Time t2 = sf::milliseconds(10);
sf::Time t3 = sf::seconds(0.01f);
```

Note that these three times are all equal. 

Similarly, a [Time]({{book.api}}/Time.html) can be converted back to either seconds, milliseconds or microseconds: 

```
sf::Time time = ...;

sf::Int64 usec = time.asMicroseconds();
sf::Int32 msec = time.asMilliseconds();
float     sec  = time.asSeconds();
```

## Playing with time values

[Time]({{book.api}}/Time.html) is just an amount of time, so it supports arithmetic operations such as addition, subtraction, comparison, etc. Times can also be negative. 

```
sf::Time t1 = ...;
sf::Time t2 = t1 * 2;
sf::Time t3 = t1 + t2;
sf::Time t4 = -t3;

bool b1 = (t1 == t2);
bool b2 = (t3 > t4);
```

## Measuring time

Now that we've seen how to manipulate time values with SFML, let's see how to do something that almost every program needs: measuring the time elapsed. 

SFML has a very simple class for measuring time: [Clock]({{book.api}}/Clock.html). It only has two functions: `getElapsedTime`, to retrieve the time elapsed since the clock started, and `restart`, to restart the clock. 

```
sf::Clock clock; // starts the clock
...
sf::Time elapsed1 = clock.getElapsedTime();
std::cout << elapsed1.asSeconds() << std::endl;
clock.restart();
...
sf::Time elapsed2 = clock.getElapsedTime();
std::cout << elapsed2.asSeconds() << std::endl;
```

Note that `restart` also returns the elapsed time, so that you can avoid the slight gap that would exist if you had to call `getElapsedTime` explicitly before `restart`.  
Here is an example that uses the time elapsed at each iteration of the game loop to update the game logic: 

```
sf::Clock clock;
while (window.isOpen())
{
    sf::Time elapsed = clock.restart();
    updateGame(elapsed);
    ...
}
```

