class Node
    attr_accessor :up, :left, :right, :name, :rating, :looking_for

    def initialize(name, rating)
        @name = name
        @rating = rating
    end

    def printn
        print "Node: #{self.name}, "
        print "Up: #{up.name}, " if self.up
        print "Left: #{left.name}, " if self.left
        print "Right: #{right.name}" if self.right
    end
end