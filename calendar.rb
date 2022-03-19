require 'date'

# init
DAYS_ORDER = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
today = Date.today
month = today.month
year = today.year
first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)
hash_days = {}

# get all current months days and add to hash_days
first_day.upto(last_day) { |day| hash_days[day.day] = day.strftime('%a') }

# group by wday
grouped_arr = hash_days.group_by { |day, wday| wday }

# sort by wday from DAYS_ORDER
sorted_arr = grouped_arr.sort_by { |k, v| DAYS_ORDER.index(k) }

#  rendering current month's calendar with mark current day
## title

print "\x1b[4m#{today.strftime("%B, %Y")}\x1b[0m\n"

## calendar
indent = true

sorted_arr.each do |wday, days|
  print wday
  if days[0][0] != 1 && indent == true
    print "   "
  else
    indent = false
  end

  days.each do |v|
    if v[0] > 9
      day = " #{v[0]}"
    else
      day = "  #{v[0]}"
  end

  current_day = "\x1b[1;31m#{day}\x1b[0m"

  print v[0] == today.day ? current_day : day
end
  puts
end
