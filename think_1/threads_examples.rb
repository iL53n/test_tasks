# Ruby
## Напишите 2 примера, каждый из которых использует потоки:
## - первый пример для вычисления CPU нагруженной задачи,
## - второй пример с ожиданием по I/O (доступ к базе данных или сети).
## Проведите бенчмарк и покажите результаты.
require 'benchmark'

# ---1
factorial = proc { |n|
  1.upto(n).inject(1) { |i, n| i * n }
}

count = 0
threads = []

Benchmark.bm do |x|
  x.report('#1') do
    10.times do
      threads << Thread.new do
        factorial.call 1000
        Thread.current['mycount'] = count
        count += 1
      end
    end
  end
end

threads.each do |t|
  t.join
  p t['mycount']
end

# ---2
call_remote = proc { |host|
  sleep 3
  # p host
}

count = 0
threads_second = []

Benchmark.bm do |x|
  x.report('#2') do
    %w[host1 host2].each do |host|
      threads_second << Thread.new do
        call_remote.call host
        Thread.current['mycount'] = count
        count += 1
      end
    end
  end
end

threads_second.each do |t|
  t.join
  p t['mycount']
end
