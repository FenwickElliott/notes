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
            puts "Bubbeling #{o.name} over #{l.rating}"
            l_up = l.up ; l_left = l.left ; l_right = l.right
            o_up = o.up ; o_left = o.left ; o_right = o.right

            # oedipus up
            o.up = l_up
            o.up = Node.new('hi',12)
            # liaus up
            l.up = o

            # oedipus down
            l_left == o ? (o.left = l ; o.right = l_right ) : (o.left = l_left ; o.right = l)
            # liaus down
            l.left = o_left ; l.right = o_right

            
            # grandchildren up 
            l_left.up = o if l_left
            l_right.up = o if l_right

            # oedipus up wasn't carrying from line 25
            o.up = l_up

            # grandparent down
            if l == @root
                puts 'rerooting'
                @root = o
            else
                # o.up = l_up
                l_up.left == l ? l_up.left = o : l_up.right = o
                bubble(o)
            end
        end
    end


    def move_tail
        ar = [@root]
        ar.each do |x|
            x.left ? ar << x.left : (return @tail = x)
            x.right ? ar << x.right : (return @tail = x)
        end
    end

      # Recursive Depth First Search
  def find(root = @root, data)
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
    finder.printn
  end
    
    def printf
        ar = [@root]
        gen = 0
        c = 1
        while ar.size > 0
            gen += 1
            return if gen > 7
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