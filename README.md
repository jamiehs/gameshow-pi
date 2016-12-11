# Raspberry Pi Game Show Buzzer Script

Provides a few simple functions to control the logic of a game show buzzer prototype. It handles 4 inputs, 4 outputs, and sound.

## Requirements

* Raspberry Pi
* LEDs, resistors, wires
* Handheld _buzzers_ or simple momentary switches

## How it works

We listen for switched being pressed:

```
loop do
  # Check randomly for switches being pressed
  # Keep checking...
end
```

Once a switch is pressed, we can then enter a paused, _answered_ state; before the answered state is paused for 5 seconds, we play some sound, and flash a few lights.
```
# If the current pin is high, do stuff.
if read_pin(pin)
  puts "Player #{pin_index + 1}!"
  buzz_in()
  light_on($output_pins[pin_index])
  sleep 5
  reset_dance()
  puts "Ready..."
end
```

The above logic simply repeats once the answered cycle is done.

## Photos

#### Completed box viewed from the front:
![Completed box viewed from the front](http://i.imgur.com/9OicMP7.png)

#### Relays used for swithing the 120v AC lights on and off
![Relays used for swithing the 120v AC lights on and off](http://i.imgur.com/kz1s4Mg.png)

#### Raspberry Pi connected to relays for final testing
![Raspberry Pi connected to relays for final testing](http://i.imgur.com/llelul7.png)
