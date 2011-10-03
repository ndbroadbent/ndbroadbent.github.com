---
layout: post
title: Christianity for Ruby programmers
excerpt: Christianity for Ruby programmers
tags: thoughts ruby
date: 2011-10-02 00:35:49 +0800
---
{% highlight ruby %}
#!/usr/bin/env ruby
require 'singleton'
require 'date'
Infinity = 1.0 / 0
# Just some shortcuts for colors.
$rd, $gr, $yl, $bl, $rs = [(31..34).map{|c| "\033[1;#{c}m" }, "\033[0m"].flatten
# Birthdate = Date.new(1970, 01, 01) # YYYY, MM, DD

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# In the beginning, there was God.
class God
  # He is the only God.
  include Singleton

  # He is perfect in holiness,
  def self.holiness
    Infinity
  end

  # and His tolerance for sin is the inverse of His perfect Holiness: zero.
  def self.sin_tolerance
    1 / holiness
  end
end

# Jesus was also with God in the beginning.
class Jesus < God
end

# God created mankind.
module Human
  # And there was only one thing that we weren't allowed to do.
  def laws
    ["Do not eat the forbidden fruit."]
  end
end

class Person
  include Human

  # We would live forever, and we enjoyed a close relationship with God.
  def mortal; false; end
  def initialize
    @lifespan = Infinity
  end
end


# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# But one day, it happened.
# Mankind disobeyed God.
# We destroyed our relationship with our Creator, and sin entered the world.

class Sin
  attr_accessor :type
  def initialize(type); @type = type; end

  # We struggle to understand why our tiny imperfections are such a big deal.
  # Most of us have never raped or murdered anybody,
  # so why don't we deserve to go to Heaven?
  def severity
     case @type
     when :white_lie;   1
     when :dishonesty;  5
     when :selfishness; 7
     when :stealing;    10
     when :adultery;    100
     when :rape;        500
     when :murder;      5000
     end
  end

  def severity_in_Gods_eyes
    # No matter how insignificant our sins appear,
    # God sees the severity of our sins as the inverse of His tolerance.
    # His perfect Holiness requires us to have a perfect record.
    severity / God.sin_tolerance
  end
end

class Person
  # So people's lives were cut short.
  def mortal
    true
  end
  # Our days were numbered,
  attr_accessor :lifespan
  def initialize
    @lifespan = (60 + rand(40)) * 365
  end

  # And our sins were counted against us.
  attr_writer :sins
  def sins
    @sins ||= []
  end

  # Sin became a habitual part of our lives.
  # (The following code simulates how often we might sin during our lifetime.)
  def probability_of_sinning
    avg_lifetime = 29220.0 # (80 years, in days)
    {
      :white_lie   => 1 / (365.0 / 2),               # Twice a year... ?
      :dishonesty  => 1 / (365.0 * 5),               # Maybe once every 5 years?
      :selfishness => 1 / (365.0 * 10),              # Maybe once every 10 years?
      :stealing    => 1 / (avg_lifetime),            # Maybe once in your life?
      :adultery    => 1 / (100000   * avg_lifetime), # 1 in 100,000 people.
      :rape        => 1 / (50000000 * avg_lifetime), # 1 in 50 million people.
      :murder      => 1 / (80000000 * avg_lifetime)  # 1 in 80 million people.
    }
  end
end

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# And God saw that His children were lost, but He still loved us.
# He decided to do something to fix this situation.

# In fact, He loved us so much that He sent His only Son to earth,
# to take the punishment that we deserve. (John 3:16)

class Jesus
  # Jesus became a human being.
  include Human

  # He lived a perfect, sinless life.
  def probability_of_sinning
    { :tempted_by_devil => 0.000 }
  end
  def perfect_record
    []
  end

  # And when He died on the cross, He provided a way for
  # our sins to be covered by His sacrifice.
  attr_writer :sins_covered_by_sacrifice
  def sins_covered_by_sacrifice
    []
  end

  def self.forgive_sins(person)
    # When we ask Him to forgive our sins, He takes them upon Himself.
    # He's already paid the price.
    Jesus.instance.sins_covered_by_sacrifice += person.sins

    person.instance_eval do
      # He replaces your sinful history with His perfect record.
      def sins
        Jesus.instance.perfect_record
      end

      # Even the sins you commit after you ask Him for forgiveness.
      def sins=(sins)
        Jesus.instance.sins_covered_by_sacrifice += sins
      end
    end

    # And when you accept His free gift of eternal life, your name is added
    # to the Lamb's Book of Life (Revelation 13:8),
    Heaven::BookOfLife.add(person)
    # and you are saved.
    person.saved = true
  end
end

class Person
  # We are all given the opportunity to either accept
  # or reject Jesus as our saviour.
  def accept_Jesus_as_saviour
    Jesus.forgive_sins(self)
  end
  attr_accessor :saved
end

module Heaven
  class BookOfLife
    class << self
      def people; @people ||= []; end
      def add(person)
        people.push(person) if !people.include?(person) && person.is_a?(Person)
      end

      # But be warned: Faith without works is dead,
      # and if you continue to live a purposefully sinful life
      # and ignore God's calling, your name will be blotted out.
      # (James 2:14-26 and Revelation 3:4-6)
      def blot_out(person)
        people = people.reject(person)
      end
    end
  end


  # Thus, the criteria for getting into heaven is simple.
  # -----------------------------------------------------

  # Either your name is in the Lamb's Book of Life,
  def self.name_is_in_book_of_life(person)
    Heaven::BookOfLife.people.include?(person)
  end

  # or you have never, ever commited a sin that deserves punishment.
  def self.person_has_not_sinned(person)
    person.sins.none?{|sin| sin.severity_in_Gods_eyes == Infinity }
  end

  def self.entry_authorized?(person)
    name_is_in_book_of_life(person) || person_has_not_sinned(person)
  end
end


# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# The following script is an interactive demonstration of the code above,
# using the RSpec test formatting style as a metaphor.

# Birth
# ------------------------------------------------------------
@you = Person.new
puts "== You were born."

# Life
# ------------------------------------------------------------
puts "== Every day you are tempted to sin. And sometimes you fail..."
sleep 2
@you.lifespan.times do |day|
  sinned_today = false

  @you.probability_of_sinning.each do |sin_type, probability|
    if rand(1 / probability) == 0.0
      sin = Sin.new(sin_type)
      @you.sins += [sin]
      sinned_today = true
    end
  end

  if day == @you.lifespan / 2
    puts "\n\n#{$rs}At some point in your life, you will hear the gospel
of Jesus Christ: That He is the Son of God, who came to earth to die for your
sins so that you may have eternal life. You are faced with the choice to
either accept or reject this truth. Do you believe? \033[1;33m(y/n)#{$rs}"
    if gets.strip.downcase[0,1] == "y"
      @you.accept_Jesus_as_saviour
      puts "\n== You have accepted Jesus Christ as your Lord and Saviour; \
all your sins are washed away! { sins.size => #{@you.sins.size} }\n\n"
      sleep 2
    end
  end

  # Print a yellow marker at today's date, if Birthdate given.
  print "#{$yl}|#{$rs}" if defined?(Birthdate) &&
                                day == (DateTime.now - Birthdate).to_i

  print sinned_today ? "\033[1;#{@you.saved ? 36 : 31}mF#{$rs}" :
                       "\033[0;32m.#{$rs}"
end

# Death
# ------------------------------------------------------------
puts "#{$yl}[EOL]#{$rs}" # End of Life on earth.


if Heaven.name_is_in_book_of_life(@you)
  puts "\n== #{$gr}Your name was found in the Lamb's \
book of life.#{$rs}  (Revelation 13:8)"
else
  puts "\n== #{$rd}Your name was not found in the Lamb's \
book of life.#{$rs}  (Revelation 13:8)"
end

if Heaven.person_has_not_sinned(@you)
  puts "== #{$gr}No sins were found. \
You have a perfect record.#{$rs}   (Romans 6:23b (NIV) - \
The gift of God is eternal life through Jesus Christ our Lord.)"
else
  puts "== #{$rd}You have been found guilty of sin.#{$rs}   \
(Romans 6:23a (NIV) - The wages of sin is death.)"
end

if Heaven.entry_authorized?(@you)
  puts "\nMatthew 25:34-36 (NIV)\n
    34 \"Then the King will say to those on his right,
       'Come, you who are blessed by my Father; take your inheritance, the kingdom
       prepared for you since the creation of the world.
    35 For I was hungry and you gave me something to eat, I was thirsty
       and you gave me something to drink, I was a stranger and you invited me in,
    36 I needed clothes and you clothed me, I was sick and you looked after me,
       I was in prison and you came to visit me.'\n\n"
else
  puts "\nMatthew 25:41-45 (NIV)\n
    41 \"Then he will say to those on his left,
       'Depart from me, you who are cursed, into the eternal fire prepared
       for the devil and his angels.
    42 For I was hungry and you gave me nothing to eat, I was thirsty and you
       gave me nothing to drink,
    43 I was a stranger and you did not invite me in, I needed clothes and you
       did not clothe me, I was sick and in prison and you did not look after me.'
    44 \"They also will answer, 'Lord, when did we see you hungry or thirsty or a
       stranger or needing clothes or sick or in prison, and did not help you?'
    45 \"He will reply, 'Truly I tell you, whatever you did not do
       for one of the least of these, you did not do for me.'\n\n"
end

{% endhighlight %}

