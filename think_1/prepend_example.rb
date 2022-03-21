## Ruby
# Напишите пример использования подключения модуля с помощью `prepend`. Пример должен быть рабочим и выполнять определённую задачу (цель)

module MyModule
  def hello
    p "Hello from MyModule!"
    super
  end
end

class MyClass
  prepend MyModule

  def hello
    p "Hello from MyClass!"
  end
end

MyClass.new.hello

# => "Hello from MyModule!"
# => "Hello from MyClass!"

p MyClass.ancestors
# => [MyModule, MyClass, Object, Kernel, BasicObject]
