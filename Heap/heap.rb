require_relative 'node'

class Heap
    attr_accessor :root, :tail

    def add(node)
        return @tail = @root = node unless @root
        @tail.left ? @tail.right = node : @tail.left = node
        node.up = @tail
        bubble(node)
        move_tail
    end

    def bubble(o)
        if o.rating > o.up.rating

            l = o.up
            l_up = l.up ; l_left = l.left ; l_right = l.right
            o_up = o.up ; o_left = o.left ; o_right = o.right

            # liaus up
            l.up = o

            # oedipus down
            l_left == o ? (o.left = l ; o.right = l_right ; o.right.up = o if o.right) : (o.left = l_left ; o.right = l)

            if l_left == o
                o.left = l
                o.right = l_right
                o.right.up = o if o.right
            elsif l_right == o
                o.left = l_left
                o.right = l
                o.left.up = o if o.left
            end

            # liaus down
            l.left = o_left ; l.right = o_right

            # grandchildren up 
            o_left.up = l if o_left
            o_right.up = l if o_right

            # grandparent down & oedipus up unless reroot
            if l == @root
                @root = o
            else
                o.up = l_up
                l_up.left == l ? l_up.left = o : l_up.right = o
                bubble(o)
            end
        end
    end


    def move_tail
        ar = [@root]
        ar.each do |x|
            x.left ? ar << x.left : ( return @tail = x )
            x.right ? ar << x.right : ( return @tail = x )
        end
    end

    def find(data)
        finder = @root
        while finder.name != data
            self.find(nil) if data && data == @root.looking_for
            if finder.left && finder.left.looking_for != data
                finder = finder.left
                finder.looking_for = data
            elsif finder.right && finder.right.looking_for != data
                finder = finder.right
                finder.looking_for = data
            elsif finder.up
                finder = finder.up
            else
                return nil
            end
        end
        puts finder.printn
        puts
    end
    
    def printf
        ar = [@root]
        gen = 0
        c = 1
        while ar.size > 0
            gen += 1
            return if gen > 10
            ar.each {|c| print c.name + "   "}
            temp = []
            ar.each {|x| 
                temp << x.left if x.left
                temp << x.right if x.right
            }
            c += temp.size
            ar = temp
            puts
        end
        puts "Count = #{c}"
    end
end