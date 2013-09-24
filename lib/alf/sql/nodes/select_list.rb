module Alf
  module Sql
    module SelectList
      include Expr

      def qualifier_proc
        ->(a){
          item = sexpr_body.find{|item| item.as_name == a }
          item && item.qualifier
        }
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
