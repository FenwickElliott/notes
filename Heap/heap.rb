require_relative 'node'

class Heap
    attr_accessor :root, :tail

    def add(node)
        return @tail = @root = node unless @root
        @tail.left ? @tail.right = node : @tail.left = node
        node.up = @tail

        swap(node)
        move_tail
    end

    def swap(o)
        # puts o.name
        l = o.up
        while l && o.rating > l.rating

            # puts o.name
        
            l_up = l.up
            l_left = l.left
            l_right = l.right

            o_up = o.up
            o_left = o.left
            o_right = o.right

            l_up.left == l ? l_up.left = o : l_up.right = o
            o.up = l_up

            l.up = o


            o.left.up = l if o.left
            o.right.up = l if o.right

            l.right = o_right
            l.left = o_left

            # puts l.name
            # puts o.name

            if l_left == o
                o.left = l
                o.right = l_right
            elsif l_right == o
                o.right = l
                o.left = l_left
            end

            # o = o.up
            l = o.up

        end
    end

    def move_tail
        ar = [@root]
        ar.each do |x|
            x.left ? ar << x.left : (return @tail = x)
            x.right ? ar << x.right : (return @tail = x)
        end
    end
    
    def printf
        ar = [@root]
        count = 0
        while ar.size > 0
            count += 1
            return if count > 7
            ar.each {|c| print c.name + "   "}
            temp = []
            ar.each {|x| 
                temp << x.left if x.left
                temp << x.right if x.right
            }
            ar = temp
            puts
        end
    end
end