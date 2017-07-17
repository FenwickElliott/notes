require_relative 'node'

class Heap
    attr_accessor :root, :tail

    def add(node)
        return @tail = @root = node unless @root
        @tail.left ? @tail.right = node : @tail.left = node
        node.up = @tail

        # while node.up && node.rating > node.up.rating
        #     if node.up == @root
        #         # return root_bubble(node)
        #         puts 'root_bubble'
        #         node = node.up
        #     else
        #         bubble(node)
        #     end
        # end

        # while node.up && node.rating > node.up.rating
        #     swap(node, node.up)
        #     node = node.up
        # end

        # bubble(node) while node.rating > node.up.rating
        bubble(node)
        move_tail
        # bubble(node) if node.rating == 99
        # bubble(node) if node.rating == 99

    end

    # redundant
    def root_bubble(o)
        @root = o
        l = o.up
        l.up = o
        o.up = nil

        o_left = o.left
        o_right = o.right

        o_left.up = l if o_left
        o_right.up = l if o_right

        if l.left == o
            o.left = l
            o.right = l.right
            o.right.up = o if o.right
        else
            o.left = l.left
            o.right = l
            o.left.up = o if o.left
        end

        l.left = o_left
        l.right = o_right
    end
    # redundant
    def swap(o,l)
        @root = o ; o.up = nil if @root == l

        o_ref = [o.up, o.left, o.right]
        l_ref = [l.up, l.left, l.right]

        l.up = o


        if l.left == o
            o.left = l
            o.right = l.right
        else
            o.right = l
            o.left = l.left
        end

        l.left = o_ref[1]
        l.right = o_ref[2]
    end
    # redundant
    def bubble(o)
        l = o.up

        l_up = l.up
        l_left = l.left
        l_right = l.right

        o_up = o.up
        o_left = o.left
        o_right = o.right

        l_up.left == l ? l_up.left = o : l_up.right = o if l_up
        o.up = l_up

        l.up = o

        o.left.up = l if o.left
        o.right.up = l if o.right

        l.right = o_right
        l.left = o_left

        if l_left == o
            o.left = l
            o.right = l_right
        elsif l_right == o
            o.right = l
            o.left = l_left
        end
        o = o.up
    end

    def bubble(o)
        if o.rating > o.up.rating
            l = o.up
            puts "Bubbeling #{o.name} over #{l.rating}"
            puts 'reroot' if l == @root
            l_up = l.up ; l_left = l.left ; l_right = l.right
            o_up = o.up ; o_left = o.left ; o_right = o.right

            # grandparent down
            l_up.left == l ? l_up.left = o : l_up.right = o
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

            bubble(o)
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