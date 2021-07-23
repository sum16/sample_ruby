class Student

    attr_accessor :name, :age

    def initialize(name, age)
        @name = name
        @age = age
    end

    def to_s
        puts "#{@name}、#{@age}"
    end

end

class StudentBook

    def initialize
        students = {}
    end

    def setUpStudent
        students = {
            :kazuki => Student.new("かずき", 27),
            :yuki => Student.new("yuki", 28),
            :yasuyuki => Student.new("yasuyuki", 30),
        }
    end
    
    def printStudent
        students.each do |key, value|
            puts "#{key} #{value.to_s}"
        end
    end

    def listAllstudent
        setUpStudent
        printStudent
    end


end

student_book = StudentBook.new
puts student_book.listAllstudent