module Alf
  module Sql
    module Processor
    end
  end
end
require_relative 'processor/support/main_select_rewriter'
require_relative 'processor/support/select_list_rewriter'
require_relative 'processor/distinct'
require_relative 'processor/clip'
require_relative 'processor/rename'
require_relative 'processor/order_by'
require_relative 'processor/limit_offset'
require_relative 'processor/from_self'
require_relative 'processor/reorder'
require_relative 'processor/merge'
