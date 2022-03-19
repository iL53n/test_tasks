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
grouped_hash = hash_days.group_by { |day| day.pop }.transform_values { |days| days.flatten }

# sort by wday from DAYS_ORDER
sorted_arr = grouped_hash.sort_by { |k, v| DAYS_ORDER.index(k) }

#  rendering current month's calendar with mark current day
## title
print "\x1b[4m#{today.strftime("%B %Y")}\x1b[0m\n"

## calendar
indent = true

sorted_arr.each do |wday, days|
  print wday

  if days[0] != 1 && indent == true
    print "   "
  else
    indent = false
  end

  days.each do |value|
    spaces = " " * (value > 9 ? 1 : 2)
    str_day = spaces + value.to_s
    current_day = "\x1b[1;31m#{str_day}\x1b[0m"

    print value == today.day ? current_day : str_day
  end

  puts
end
