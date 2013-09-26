module Alf
  module Sql
    module SelectList
      include Expr

      def desaliaser
        ->(a){
          item = sexpr_body.find{|item| item.as_name.to_s == a.to_s }
          item && item.left
        }
      end

      def knows?(as_name)
        find_child{|child| child.as_name == as_name }
      end

      def to_attr_list
        AttrList.coerce(sexpr_body.map{|a| a.as_name })
      end

      def to_sql(buffer = "")
        sexpr_body.each_with_index do |item,index|
          buffer << ", " unless index == 0
          item.to_sql(buffer)
        end
        buffer
      end

    end # module SelectList
  end # module Sql
end # module Alf
