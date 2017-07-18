require_relative 'node'

class Heap
    attr_accessor :root, :tail

    def add(node)
        return @tail = @root = node unless @root
        @tail.left ? @tail.right = node : @tail.left = node
        node.up = @tail

        
        bubble(node)
        move_tail
        printf
        puts
    end

    def bubble(o)
        if o.rating > o.up.rating

            l = o.up
            # puts "Bubbeling #{o.name} over #{l.rating}"
            l_up = l.up ; l_left = l.left ; l_right = l.right
            o_up = o.up ; o_left = o.left ; o_right = o.right

            # l_up.left == l ? l_up.left = o : l_up.right = o

            # liaus up
            l.up = o

            # oedipus down
            l_left == o ? (o.left = l ; o.right = l_right ) : (o.left = l_left ; o.right = l)

            if l_left == o
            # if true
                puts "Left: Bubbeling #{o.name} over #{l.name}"
                o.left = l
                o.right = l_right
                o.right.up = o if o.right
            elsif l_right == o
                puts "Right: Bubbeling #{o.name} over #{l.name}"
                o.printn
                puts
                l.printn
                puts
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
                puts 'rerooting'
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
            x.left ? ar << x.left : ( puts "Tail " + @tail.name ; return @tail = x)
            x.right ? ar << x.right : ( puts "Tail " + @tail.name ; return @tail = x)
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