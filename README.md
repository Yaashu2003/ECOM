# ECOM
SWARNA YAAJU SHENDRA,IV RAHUL. 
E-commerce Website Documentation:
Overview
This e-commerce website provides a platform where users can browse products, add items to their cart, and make purchases. The website features a user registration and login system, product categorization, a shopping cart, and order management.

Website Structure
1. Homepage (index.jsp)
Navbar: Contains links to Home, Sell, Order History, Categories, Cart, and Logout. Displays the logged-in user's name.
Search Bar: Allows users to search for products.
Carousel: Displays promotional images.
Product Sections: Displays featured products and best sellers with options to view details, buy now, or add to cart.
2. Login Page (login.jsp)
Form: Allows users to log in by entering their username and password.
Validation: Checks credentials against the database and starts a session on successful login.
3. Registration Page (register.jsp)
Form: Allows new users to create an account by providing necessary details.
Validation: Saves user details in the database.
4. Product Listing Page (products.jsp)
Product Display: Lists products based on the selected category with options to view details, buy now, or add to cart.
5. Product Details Page (productDetails.jsp)
Product Information: Displays detailed information about a selected product.
Reviews Section: Shows reviews for the product and allows logged-in users to post new reviews.
6. Cart Page (cart.jsp)
Cart Items: Displays products added to the cart by the user.
Actions: Allows users to remove items from the cart or proceed to checkout.
7. Checkout Page (checkout.jsp)
Summary: Displays a summary of the cart items and total cost.
Proceed to Order: Allows users to proceed with the order placement.
8. Order History Page (orderHistory.jsp)
Order List: Displays a list of past orders made by the user.
9. Logout Page (logout.jsp)
Logout Action: Ends the user's session and redirects to the login page.
10. Add to Cart (addToCart.jsp)
Action: Adds a selected product to the user's cart and updates the cart count.
11. Remove from Cart (removeFromCart.jsp)
Action: Removes a selected product from the user's cart.
12. Post Review (postReview.jsp)
Action: Allows users to post reviews for products.
Database Structure
1. Users1
user_id (INT, Primary Key): Unique identifier for each user.
username (VARCHAR2(50), UNIQUE, NOT NULL): Username of the user.
password (VARCHAR2(255), NOT NULL): Password of the user.
email (VARCHAR2(100), UNIQUE, NOT NULL): Email of the user.
2. Categories
category_id (INT, Primary Key): Unique identifier for each category.
name (VARCHAR2(100), NOT NULL): Name of the category.
description (CLOB): Description of the category.
3. Products
product_id (INT, Primary Key): Unique identifier for each product.
category_id (INT, Foreign Key): Identifier linking to the product's category.
name (VARCHAR2(100), NOT NULL): Name of the product.
description (CLOB): Description of the product.
price (NUMBER(10, 2), NOT NULL): Price of the product.
stock_quantity (INT, DEFAULT 0): Quantity of the product in stock.
image_url (VARCHAR(255)): URL of the product image.
4. Orders
order_id (INT, Primary Key): Unique identifier for each order.
user_id (INT, Foreign Key): Identifier linking to the user who placed the order.
order_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Date and time when the order was placed.
status (VARCHAR2(50), NOT NULL): Current status of the order.
total_amount (NUMBER(10, 2), NOT NULL): Total amount for the order.
5. OrderDetails
order_detail_id (INT, Primary Key): Unique identifier for each order detail.
order_id (INT, Foreign Key): Identifier linking to the order.
product_id (INT, Foreign Key): Identifier linking to the product.
quantity (INT, NOT NULL): Quantity of the product ordered.
price (NUMBER(10, 2), NOT NULL): Price of the product at the time of the order.
6. Payments
payment_id (INT, Primary Key): Unique identifier for each payment.
order_id (INT, Foreign Key): Identifier linking to the order.
payment_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Date and time when the payment was made.
amount (NUMBER(10, 2), NOT NULL): Amount paid.
payment_method (VARCHAR2(50), NOT NULL): Method of payment.
7. Shipping
shipping_id (INT, Primary Key): Unique identifier for each shipment.
order_id (INT, Foreign Key): Identifier linking to the order.
shipping_address (CLOB, NOT NULL): Address to which the order is shipped.
shipping_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Date and time when the order was shipped.
delivery_date (TIMESTAMP): Date and time when the order was delivered.
status (VARCHAR2(50), NOT NULL): Current status of the shipment.
8. Reviews
review_id (INT, Primary Key): Unique identifier for each review.
product_id (INT, Foreign Key): Identifier linking to the reviewed product.
user_id (INT, Foreign Key): Identifier linking to the user who wrote the review.
rating (INT, CHECK (rating >= 1 AND rating <= 5)): Rating given by the user.
review_text (CLOB): Review text.
9. Addresses
address_id (INT, Primary Key): Unique identifier for each address.
user_id (INT, Foreign Key): Identifier linking to the user.
address_line1 (VARCHAR2(255), NOT NULL): First line of the address.
address_line2 (VARCHAR2(255)): Second line of the address.
city (VARCHAR2(100), NOT NULL): City of the address.
state (VARCHAR2(100), NOT NULL): State of the address.
postal_code (VARCHAR2(20), NOT NULL): Postal code of the address.
country (VARCHAR2(100), NOT NULL): Country of the address.
10. Cart
cart_id (INT, Primary Key): Unique identifier for each cart item.
user_id (INT, Foreign Key): Identifier linking to the user.
product_id (INT, Foreign Key): Identifier linking to the product.
quantity (INT, NOT NULL): Quantity of the product in the cart.
11. Wishlist
wishlist_id (INT, Primary Key): Unique identifier for each wishlist item.
user_id (INT, Foreign Key): Identifier linking to the user.
product_id (INT, Foreign Key): Identifier linking to the product.
12. Coupons
coupon_id (INT, Primary Key): Unique identifier for each coupon.
code (VARCHAR2(50), UNIQUE, NOT NULL): Coupon code.
discount (NUMBER(10, 2), NOT NULL): Discount percentage or amount.
expiry_date (DATE): Expiry date of the coupon.
13. Logs
log_id (INT, Primary Key): Unique identifier for each log entry.
user_id (INT, Foreign Key): Identifier linking to the user.
action (VARCHAR2(255), NOT NULL): Description of the action.
action_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Date and time when the action was performed.
Additional Functionality
1. Add to Cart (addToCart.jsp)
Function: Adds selected product to the user's cart and increments the cart count.
Parameters: product_id, user_id.
2. Remove from Cart (removeFromCart.jsp)
Function: Removes selected product from the user's cart and decrements the cart count.
Parameters: product_id, user_id.
3. Post Review (postReview.jsp)
Function: Allows users to post reviews for products.
Parameters: product_id, user_id, rating, review_text.
4. Checkout (checkout.jsp)
Function: Displays a summary of the cart items and allows users to proceed with order placement.
Parameters: user_id.
5. Complete Order (completeOrder.jsp)
Function: Finalizes the order and records payment and shipping details.
Parameters: order_id, user_id.
Usage
User Registration: New users must register on the register.jsp page.
User Login: Registered users can log in via
