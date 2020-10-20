# Spatialization: Sounds in 3D

## Introduction

By default, sounds and music are played at full volume in each speaker; they are not *spatialized*.

If a sound is emitted by an entity which is to the right of the screen, you would probably want to hear it from the right speaker. If a music is being played behind the player, you would want to hear it from the rear speakers of your Dolby 5.1 sound system.

How can this be achieved?

## Spatialized sounds are mono

A sound can be spatialized only if it has a single channel, i.e. if it's a mono sound.  
Spatialization is disabled for sounds with more channels, since they already explicitly decide how to use the speakers. This is very important to keep in mind.

## The listener

All the sounds and music in your audio environment will be heard by a single actor: the *listener*. What is output from your speakers is determined by what the listener hears.

The class which defines the listener's properties is [SF::Listener][]. Since the listener is unique in the environment, this class only contains class methods and is not meant to be instantiated.

First, you can set the listener's position in the scene:

```crystal
SF::Listener.position = SF.vector3f(10.0, 0.0, 5.0)
```

If you have a 2D world you can just use the same Y value everywhere, usually 0.

In addition to its position, you can define the listener's orientation:

```crystal
SF::Listener.direction = SF.vector3f(1.0, 0.0, 0.0)
```

Here, the listener is oriented along the +X axis. This means that, for example, a sound emitted at (15, 0, 5) will be heard from the right speaker.

The "up" vector of the listener is set to (0, 1, 0) by default, in other words, the top of the listener's head is pointing towards +Y. You can change the "up" vector if you want. It is rarely necessary though.

```crystal
SF::Listener.up_vector = SF.vector3f(1.0, 1.0, 0.0)
```

This corresponds to the listener tilting their head towards the right (+X).

Finally, the listener can adjust the global volume of the scene:

```crystal
SF::Listener.global_volume = 50.0
```

The value of the volume is in the range [0 .. 100], so setting it to 50 reduces it to half of the original volume.

Of course, all these properties can be read with the corresponding getter methods.

## Audio sources

Every audio source provided by SFML (sounds, music, streams) defines the same properties for spatialization.

The main property is the position of the audio source.

```crystal
sound.position = SF.vector3f(2.0, 0.0, -5.0)
```

This position is absolute by default, but it can be relative to the listener if needed.

```crystal
sound.relative_to_listener = true
```

This can be useful for sounds emitted by the listener itself (like a gun shot, or foot steps). It also has the interesting side-effect of disabling spatialization if you set the position of the audio source to (0, 0, 0). Non-spatialized sounds can be required in various situations: GUI sounds (clicks), ambient music, etc.

You can also set the factor by which audio sources will be attenuated depending on their distance to the listener.

```crystal
sound.min_distance = 5.0
sound.attenuation = 10.0
```

The *minimum distance* is the distance under which the sound will be heard at its maximum volume. As an example, louder sounds such as explosions should have a higher minimum distance to ensure that they will be heard from far away. Please note that a minimum distance of 0 (the sound is inside the head of the listener!) would lead to an incorrect spatialization and result in a non-attenuated sound. 0 is an invalid value, never use it.

The *attenuation* is a multiplicative factor. The greater the attenuation, the less it will be heard when the sound moves away from the listener. To get a non-attenuated sound, you can use 0. On the other hand, using a value like 100 will highly attenuate the sound, which means that it will be heard only if very close to the listener.

Here is the exact attenuation formula, in case you need accurate values:

- *MinDistance*   is the sound's minimum distance, set with min_distance=
- *Attenuation*   is the sound's attenuation, set with attenuation=
- *Distance*      is the distance between the sound and the listener
- *Volume factor* is the calculated factor, in range [0 .. 1], that will be applied to the sound's volume

`Volume factor = MinDistance / (MinDistance + Attenuation * (max(Distance, MinDistance) - MinDistance))`

