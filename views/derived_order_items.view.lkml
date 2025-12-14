view: derived_order_items {
    derived_table: {
      explore_source: order_items {
        column: sale_price {}
        column: count {}
        column: order_id {}
        column: user_id {}
      }
    }
    dimension: sale_price {
      description: ""
      type: number
    }
    dimension: count {
      description: ""
      type: number
    }
    dimension: order_id {
      description: ""
      type: number
    }
    dimension: user_id {
      description: ""
      type: number
    }
  }
