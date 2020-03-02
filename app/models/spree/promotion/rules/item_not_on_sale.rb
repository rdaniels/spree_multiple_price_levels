module Spree
  class Promotion
    module Rules
      class ItemNotOnSale < PromotionRule
        def applicable?(promotable)
          promotable.is_a?(Spree::Order)
        end

        def eligible?(order, _options = {})
          return true
        end

        def actionable?(line_item)
          not line_item.variant.on_sale?
        end
      end
    end
  end
end
