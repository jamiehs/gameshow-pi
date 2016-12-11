# A note on Ruby shell execution:
# System calls are synchronous, but print output.
# Backticks are asynchronous, but return output.

$power_pin = 29

$output_pins = [1, 4, 5, 6]
$input_pins  = [3, 0, 2, 7]

def setup
  $output_pins.each do |pin|
    system "gpio mode #{pin} out"
  end
  $input_pins.each do |pin|
    system "gpio mode #{pin} in"
  end

  # blink all lights
  lights_on()
  sleep 1
  lights_off()
end

def lights_off
  $output_pins.each do |pin|
    system "gpio write #{pin} 0"
  end
end

def lights_on
  $output_pins.each do |pin|
    system "gpio write #{pin} 1"
  end
end

def light_on(pin=false)
  if pin
    system "gpio write #{pin.to_i} 1"
  else
    system "gpio write #{$output_pins.sample} 1"
  end
end

def light_off(pin=false)
  if pin
    system "gpio write #{pin.to_i} 0"
  else
    lights_off()
  end
end

def read_pin(pin)
  value = `gpio read #{pin}`
  value.to_i == 1 ? true : false
end

def startup_dance
  # initial start sequence
  number_of_blinks = 22
  interval = 0.2

  # play startup tune
  system "aplay -q pacman_intermission.wav &"

  # emulate pacman tempo
  number_of_blinks.times do
    light_on()
    sleep interval / 2
    lights_off()
    sleep interval / 2
  end
end

def reset_dance
  shuffled_pins = $output_pins.shuffle
  shuffled_pins.each do |pin|
    sleep 0.05
    light_on(pin)
  end
  shuffled_pins.reverse.each do |pin|
    sleep 0.3
    light_off(pin)
  end
  sleep 0.5
end

def buzz_in
  system "aplay -q ff-ringin.wav &"
end






puts "Press [CTRL+C] to stop.."

setup()

startup_dance()

# listen for buzzers
puts "waiting..."
loop do

  # Power down?
  if read_pin($power_pin)
    `sudo halt`
  end

  # Check pins in a random order to see if any of them is high.
  # If a high pin is found, then the loop stops and proceeds
  # with other actions such as lights, buzzers and such.
  $input_pins.shuffle.each do |pin|

    # Was this pin index 0, 1, 2, or 3 in the input pin array?
    pin_index = $input_pins.index(pin)

    # If the current pin is high, do stuff.
    if read_pin(pin)
      puts "Player #{pin_index + 1}!"
      buzz_in()
      light_on($output_pins[pin_index])
      sleep 5
      reset_dance()
      puts "Ready..."
    end
  end
  # Keep checking...
end
