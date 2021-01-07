# Threads

## What is a thread?

Most of you should already know what a thread is, however here is a little explanation for those who are really new to this concept.

A thread is basically a sequence of instructions that run in parallel to other threads. Every program is made of at least one thread: the main one, which runs the top level code in your program. Programs that only use the main thread are *single-threaded*, if you add one or more threads they become *multi-threaded*.

So, in short, threads are a way to do multiple things at the same time. This can be useful, for example, to display an animation and reacting to user input while loading images or sounds. Threads are also widely used in network programming, to wait for data to be received while continuing to update and draw the application.

## SFML threads or alternatives?

Multithreaded code is inherently unsafe. Crystal itself has a `Thread` class, but it is classified as internal, because better ways to do concurrency are being developed. Crystal's standard library is not intended to be used with raw threads. **Garbage collection in additional threads causes crashes.** Exceptions don't work either.

Please make sure you know what you're doing before choosing SFML threads.

## Creating a thread with CrSFML

Enough talk, let's see some code. The class that makes it possible to create threads in CrSFML is [SF::Thread][], and here is what it looks like in action:

```crystal
require "crsfml/system"

def func
  # this function is started when thread.launch() is called

  7.times do
    puts "I'm thread number one"
    SF.sleep SF.seconds(0.3)
  end
end

# create a thread with func() as entry point
thread = SF::Thread.new(->func)

# run it
thread.launch()

# the main thread continues to run...
SF.sleep SF.seconds(0.15)

7.times do
  puts "I'm the main thread"
  SF.sleep SF.seconds(0.3)
end
```

In this code, both `main` and `func` run in parallel after `thread.launch()` has been called. The result is that text from both functions should be mixed in the console:

```
I'm thread number one
I'm the main thread
I'm thread number one
I'm the main thread
I'm thread number one
I'm the main thread
I'm thread number one
I'm the main thread
I'm thread number one
I'm the main thread
I'm thread number one
I'm the main thread
I'm thread number one
I'm the main thread
```

The entry point of the thread, ie. the function that will be run when the thread is started, must be passed to the constructor of [SF::Thread][]. [SF::Thread][] can accept any kind of [procs](https://crystal-lang.org/reference/syntax_and_semantics/literals/proc.html) without parameters.

## Starting threads

Once you've created a [SF::Thread][] instance, you must start it with the `launch` method.

```crystal
thread = SF::Thread.new(->func)
thread.launch()
```

`launch` calls the function that you passed to the constructor in a new thread, and returns immediately so that the calling thread can continue to run.

## Stopping threads

A thread automatically stops when its entry point function returns. If you want to wait for a thread to finish from another thread, you can call its `wait` method.

```crystal
thread = SF::Thread(->func)

# start the thread
thread.launch()

...

# block execution until the thread is finished
thread.wait()
```

The `wait` method is also implicitly called by the destructor of [SF::Thread][], so that a thread cannot remain alive (and out of control) after its owner [SF::Thread][] instance is destroyed. Keep this in mind when you manage your threads (see the last section of this tutorial).

## Pausing threads

There's no method in [SF::Thread][] that allows another thread to pause it, the only way to pause a thread is to do it from the code that it runs. In other words, you can only pause the current thread. To do so, you can call the `SF.sleep` function, as demonstrated in the first example.

`SF.sleep` has one argument, which is the time to sleep. This duration can be given with any unit/precision, as seen in the [time tutorial](time.md "Time tutorial").
Note that you can make any thread sleep with this function, even the main one.

`SF.sleep` is the most efficient way to pause a thread: as long as the thread sleeps, it requires zero CPU. Pauses based on active waiting, like empty `while` loops, would consume 100% CPU just to do... nothing. However, keep in mind that the sleep duration is just a hint, depending on the OS it will be more or less accurate. So don't rely on it for very precise timing.

## Protecting shared data

All the threads in a program share the same memory, they have access to all variables in the scope they are in. It is very convenient but also dangerous: since threads run in parallel, it means that a variable or function might be used concurrently from several threads at the same time. If the operation is not *thread-safe*, it can lead to undefined behavior (ie. it might crash or corrupt data).

In the first example we had to make sure that the `puts` calls never happen at the same time, by applying appropriate timing. If the sleeps are gone, the program crashes. Crystal's standard library is not intended to be used with raw threads.

Several programming tools exist to help you protect shared data and make your code thread-safe, these are called synchronization primitives. Common ones are mutexes, semaphores, condition variables and spin locks. They are all variants of the same concept: they protect a piece of code by allowing only certain threads to access it while blocking the others.

The most basic (and used) primitive is the mutex. Mutex stands for "MUTual EXclusion": it ensures that only a single thread is able to run the code that it guards. Let's see how they can bring some order to the example above:

```crystal
require "crsfml/system"

class Foo
  @mutex = SF::Mutex.new

  def task
    @mutex.lock

    7.times { puts "I'm thread number one" }

    @mutex.unlock
  end

  def main
    thread = SF::Thread.new(->task)
    thread.launch

    @mutex.lock

    7.times { puts "I'm the main thread" }

    @mutex.unlock

    thread.wait # wait until function task has finished
  end
end

foo = Foo.new
foo.main
```

This code uses a shared resource (standard output). Inappropriate use of it causes the lines/letters to be randomly mixed or even crashes. To avoid this, we protect the corresponding region of the code with a mutex.

The first thread that reaches its `mutex.lock()` line succeeds to lock the mutex, directly gains access to the code that follows and prints its text. When the other thread reaches its `mutex.lock()` line, the mutex is already locked and thus the thread is put to sleep (like `SF.sleep`, no CPU time is consumed by the sleeping thread). When the first thread finally unlocks the mutex, the second thread is awoken and is allowed to lock the mutex and print its text block as well. This leads to the lines of text appearing sequentially in the console instead of being mixed.

```
I'm the main thread
I'm the main thread
I'm the main thread
I'm the main thread
I'm the main thread
I'm the main thread
I'm the main thread
I'm thread number one
I'm thread number one
I'm thread number one
I'm thread number one
I'm thread number one
I'm thread number one
I'm thread number one
```

Mutexes are not the only primitive that you can use to protect your shared variables, but it should be enough for most cases. However, if your application does complicated things with threads, and you feel like it is not enough, don't hesitate to look for alternatives.

## Protecting mutexes

Don't worry: mutexes are already thread-safe, there's no need to protect them. But what if there is a failure in the code and the mutex never gets a chance to be unlocked? It remains locked forever. All threads that try to lock it in the future will block forever, and in some cases, your whole application could freeze. Pretty bad result.

To make sure that mutexes are always unlocked in an environment where exceptions can be thrown, CrSFML provides a special method that receives a block: `synchronize`. The mutex is locked before the block and is unlocked after the block (even if an exception is raised).

Thus, we can write previous code example in a simpler way, using `synchronize` like this:

```crystal
require "crsfml/system"

class Foo
  @mutex = SF::Mutex.new

  def task
    @mutex.synchronize do # lock mutex implicitly
      7.times { puts "I'm thread number one" }
    end # unlock mutex implicitly
  end

  def main
    thread = SF::Thread.new(->task)
    thread.launch

    @mutex.synchronize do # same as above
      7.times { puts "I'm the main thread" }
    end

    thread.wait
  end
end

foo = Foo.new
foo.main
```

## Common mistakes

One thing that is often overlooked by programmers is that a thread cannot live without its corresponding [SF::Thread][] instance.
The following code is often seen:

```crystal
def func
  SF.sleep(SF.seconds(10))
end

def start_thread
  SF::Thread.new(->func).launch
end

start_thread()
# ...
```

Programmers who write this kind of code expect the `start_thread` function to start a thread that will live on its own and be destroyed when the threaded function ends. This is not what happens. The threaded function appears to block the main thread, as if the thread wasn't working.

What is the cause of this? The [SF::Thread][] instance is local to the `start_thread()` function and is therefore destroyed, when the function returns. The finalizer of [SF::Thread][] is invoked, which calls `wait()` as we've learned above, and the result is that the main thread blocks and waits for the threaded function to be finished instead of continuing to run in parallel.

So don't forget: You must manage your [SF::Thread][] instance so that it lives as long as the threaded function is supposed to run.
