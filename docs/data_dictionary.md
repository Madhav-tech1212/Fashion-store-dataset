# Data Dictionary

## Dataset Overview

| Column              | Data Type | Category  | Description                         | Business Purpose          |
| :------------------ | :-------- | :-------- | :---------------------------------- | :------------------------ |
| product_id          | STRING    | Dimension | Unique identifier for each product  | Product identification    |
| category            | STRING    | Dimension | Product category                    | Category analysis         |
| brand               | STRING    | Dimension | Fashion brand                       | Brand performance         |
| season              | STRING    | Dimension | Selling season                      | Seasonal analysis         |
| size                | STRING    | Dimension | Product size                        | Size preference analysis  |
| color               | STRING    | Dimension | Product color                       | Color trend analysis      |
| original_price      | FLOAT     | Measure   | Original product price              | Pricing analysis          |
| markdown_percentage | FLOAT     | Measure   | Discount percentage                 | Discount effectiveness    |
| current_price       | FLOAT     | Measure   | Final selling price                 | Revenue analysis          |
| purchase_date       | DATE      | Date      | Purchase date                       | Time-series analysis      |
| stock_quantity      | INTEGER   | Measure   | Remaining inventory                 | Inventory analysis        |
| customer_rating     | FLOAT     | Measure   | Customer rating (1–5)               | Customer satisfaction     |
| is_returned         | BOOLEAN   | Dimension | Product returned or not             | Return analysis           |
| return_reason       | STRING    | Dimension | Reason for return                   | Return root-cause analysis|