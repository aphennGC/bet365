connection: "thelook"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

datagroup: ecommerce_data_updates {
  label: "E-commerce Data Refresh"
  description: "Refreshes based on the last order update time."
  sql_trigger: SELECT MAX(updated_at) FROM orders ;;
  max_cache_age: "1 hour"  ## Safety net: Invalidate cache after 1 hour max, even if no updates.
}

# Select the views that should be a part of this model,
# and define the joins that connect them together.

explore: derived_order_items {}

explore: order_items {
  persist_with: ecommerce_data_updates

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;; ##indirect join
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
