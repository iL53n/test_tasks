# Ruby
## Предложите вариант рефакторинга с использованием полиморфизма для фрагмента кода: 
=begin
class Search
  def search(type)
    case type
      when :job
        search_jobs
      when :user 
        search_users
      else
        raise 'Unknown search type'
      end
  end
end
=end

## 1. Реализация через наследование
class Search
  def search
    p "Search called in #{self.class} class!"
  end
end

class Job < Search
end

class User < Search
end

Job.new.search
User.new.search

# => "Search called in Job class!"
# => "Search called in User class!"

## 2. Реализация через динамическую типизацию
class Job
  def search
    p "Search called in #{self.class} class!"
  end
end

class User
  def search
    p "Search called in #{self.class} class!"
  end
end

class Search
  def search(receiver)
    receiver.search
  end
end

searcher = Search.new
searcher.search(Job.new)
searcher.search(User.new)

# => "Search called in Job class!"
# => "Search called in User class!"
