---
layout: post
title: How to calculate Easter Sunday
wordpress_id: 420
tags: guides ruby home-automation
date: 2011-03-31 17:41:27 +08:00
wordpress_url: http://www.f-77.com/?p=420
---
I wanted the LCD screen on my apartment door to display a message on certain days,
such as birthdays, Christmas, and Easter.
I didn't realize how hard it was to calculate which day Easter Sunday is...

{% highlight ruby %}
def easter(year)
  c=year/100
  n=year-19*(year/19)
  k=(c-17)/25
  i=c-c/4-(c-k)/3+19*n+15
  i-=30*(i/30)
  i-=(i/28)*(1 -(i/28)*(29/(i+1))*((21-n)/11))
  j=year+year/4+i+2-c+c/4
  j-=7*(j/7)
  l=i-j
  month=3+(l+40)/44
  day=l+28-31*(month/4)
  [day, month]
end
{% endhighlight %}

This happens to be the first Sunday after the Paschal full moon following the northern hemisphere's vernal equinox.


Christmas, for comparison:

{% highlight ruby %}
def christmas(year)
  [25, 12]
end
{% endhighlight %}

