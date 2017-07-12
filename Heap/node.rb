class Node
    attr_accessor :up, :left, :right, :name, :rating

    def initialize(name, rating)
        @name = name
        @rating = rating
    end
end