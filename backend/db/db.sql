CREATE DATABASE foodfinds;
USE foodfinds;

CREATE TABLE schools (
    id INT PRIMARY KEY AUTO_INCREMENT, -- we might want to use UUID to generate ids but I'll leave it with you to choose
    school_name VARCHAR(255) NOT NULL,
    -- domain is used to verify user emails when signing up 
    -- only school email allowed for students
    -- vendors will need approval from admins but they can use any email or we could also stick to giving vendors a school email
    email_domain VARCHAR(255) NOT NULL,
    logo_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    school_id INT NOT NULL,
    email VARCHAR(255) NOT NULL,
    pwd_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL, -- for calls and shih
    user_type VARCHAR(20) NOT NULL,
    -- only admins should be allowed to change the is_blocked. 
    -- They should only be allowed to use it to block reported students & vendors in their school.
    is_blocked BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT user_type_check CHECK (user_type IN ('admin', 'vendor', 'student')),
    FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE
);

-- Want to allow only one admin per sc  hool; Remove if it doesn't make sense
CREATE TABLE admins (
    id INT PRIMARY KEY,
    school_id INT NOT NULL,
    UNIQUE (school_id), -- Limit to one admin per school
    FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE
);

CREATE TABLE students (
    id INT PRIMARY KEY,
    profile_image_url TEXT,
    default_delivery_location TEXT,
    dietary_preferences TEXT, -- JSON might be better, idk
    notification_preferences JSON, -- Ehhh idk about this. Probably going to use apis for notifications but chaley
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE vendors (
    id INT PRIMARY KEY,
    vendor_name VARCHAR(255) NOT NULL, -- The business name. The fields in the user table will be the owner's name or something
    vendor_contact VARCHAR(20) NOT NULL, -- The business contact number
    logo_url TEXT,
    business_address TEXT,
    business_description TEXT,
    -- Wanted to make business_days enum but I'm thinking some vendors could have irregular patterns. Eg: Monday-Friday, Sunday.
    business_days JSON, -- i don't think sql has list so i used json... maybe there's a better way
    open_time TIME NOT NULL,
    close_time TIME NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE
);

-- Categories will be like breakfast, lunch, dinner, drinks, snacks, and stuff
-- Probably gonna let the vendors create their own categories
-- There's no vendor id for the categories because different vendors could have the same category.
-- I'm not sure if that will be a problem or not. You could add it if you think it's relevant.
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(100) NOT NULL,
    school_id INT,
    UNIQUE (category, school_id), -- Can't have more than one of the same category per school
    FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE
);

CREATE TABLE menu_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vendor_id INT NOT NULL,
    category_id INT,
    meal_name VARCHAR(255) NOT NULL,
    meal_description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    image_url TEXT,
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (vendor_id) REFERENCES vendors(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- For implementing discounts
CREATE TABLE special_offers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vendor_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    offer_description TEXT,
    -- discount type will allow the vendor choose a percentage or set a fixed discount amount
    -- will probably have to handle potential negative values on the frontend
    discount_type VARCHAR(10) NOT NULL,
    discount DECIMAL(10, 2) NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT discount_type_check CHECK (discount_type IN ('amount', 'percentage')),
    CONSTRAINT discount_value_check CHECK (
        (discount_type = 'percentage' AND discount BETWEEN 0 AND 100) OR
        (discount_type = 'amount' AND discount >= 0)
    ), -- make sure the discount entered makes sense as a percentage or price
    FOREIGN KEY (vendor_id) REFERENCES vendors(id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    vendor_id INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    special_instructions TEXT,
    delivery_location TEXT, -- if this is null, the location in the student's profile will be used
    placed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP DEFAULT NULL,
    delivered_at TIMESTAMP DEFAULT NULL,
    cancelled_at TIMESTAMP DEFAULT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT order_status_check CHECK (order_status IN ('pending', 'completed', 'delivered', 'cancelled')),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (vendor_id) REFERENCES vendors(id) ON DELETE CASCADE
);

CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    special_instructions TEXT, -- maybe there are specific instructions for each item
    CONSTRAINT quantity_check CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE
);

-- For registered users (to allow persistent carts). 
-- Unregistered users will have their carts stored in the browser (if I'm not lazy)
CREATE TABLE carts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    vendor_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (student_id, vendor_id),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (vendor_id) REFERENCES vendors(id) ON DELETE CASCADE
);

CREATE TABLE cart_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT cart_quantity_check CHECK (quantity > 0),
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE
);

CREATE TABLE vendor_ratings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    vendor_id INT NOT NULL,
    rating INT NOT NULL,
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (student_id, vendor_id), -- Each student can only rate a vendor once
    CONSTRAINT vendor_rating_check CHECK (rating BETWEEN 1 AND 5),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (vendor_id) REFERENCES vendors(id) ON DELETE CASCADE
);

CREATE TABLE menu_item_ratings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    rating INT NOT NULL,
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (student_id, menu_item_id), -- Each student can only rate an item once
    CONSTRAINT menu_item_rating_check CHECK (rating BETWEEN 1 AND 5),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE
);

CREATE TABLE order_ratings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    order_id INT NOT NULL,
    rating INT NOT NULL,
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (student_id, order_id), -- Each student can only rate an order once
    CONSTRAINT order_rating_check CHECK (rating BETWEEN 1 AND 5),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

CREATE TABLE favorite_vendors (
    student_id INT NOT NULL,
    vendor_id INT NOT NULL,
    PRIMARY KEY (student_id, vendor_id),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (vendor_id) REFERENCES vendors(id) ON DELETE CASCADE
);

CREATE TABLE favorite_menu_items (
    student_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    PRIMARY KEY (student_id, menu_item_id),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE
);

CREATE TABLE reports (
    id INT PRIMARY KEY AUTO_INCREMENT,
    reporter_id INT NOT NULL,
    reported_id INT NOT NULL,
    report_reason TEXT,
    report_status VARCHAR(20) NOT NULL, -- resolved means the admin has taken action,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT report_status_check CHECK (report_status IN ('pending', 'resolved')),
    FOREIGN KEY (reporter_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (reported_id) REFERENCES users(id) ON DELETE CASCADE
);


INSERT INTO schools (school_name, email_domain, logo_url)
VALUES ('University of Ghana', 'ug.edu.gh', 'https://example.com/ug_logo.png');

INSERT INTO users (school_id, email, pwd_hash, first_name, last_name, phone_number, user_type)
VALUES (1, 'admin@ug.edu.gh', 'password_hash', 'Victor', 'Quagraine', '+233201234567', 'admin');

INSERT INTO admins (id, school_id)
VALUES (1, 1);

INSERT INTO users (school_id, email, pwd_hash, first_name, last_name, phone_number, user_type)
VALUES (1, 'student@ug.edu.gh', 'password_hash', 'John', 'Doe', '+233207654321', 'student');

INSERT INTO students (id, profile_image_url, default_delivery_location, dietary_preferences)
VALUES (2, 'https://example.com/john_profile.jpg', 'Legon Hall, Room 42', 'No nuts');

INSERT INTO users (school_id, email, pwd_hash, first_name, last_name, phone_number, user_type)
VALUES (1, 'vendor@example.com', 'password_hash', 'Jane', 'Smith', '+233241234567', 'vendor');

INSERT INTO vendors (id, vendor_name, vendor_contact, logo_url, business_address, business_description, business_days, open_time, close_time)
VALUES (3, 'Campus Bites', '+233241234588', 'https://example.com/logo.png', 'Main Campus, Shop 5',
       'Delicious local meals', '["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]', '08:00:00', '20:00:00');

INSERT INTO categories (category, school_id)
VALUES ('Breakfast', 1);

INSERT INTO menu_items (vendor_id, category_id, meal_name, meal_description, price, image_url, is_available)
VALUES (3, 1, 'Waakye Special', 'Rice and beans with assorted protein and sides', 25.00, 'https://example.com/waakye.jpg', TRUE);

INSERT INTO special_offers (vendor_id, menu_item_id, offer_description, discount_type, discount, start_date, end_date)
VALUES (3, 1, 'Morning Special', 'percentage', 10.00, '2023-10-01 00:00:00', '2023-11-01 00:00:00');

INSERT INTO orders (student_id, vendor_id, total_price, order_status, special_instructions, delivery_location)
VALUES (2, 3, 25.00, 'pending', 'Please add extra pepper', 'Legon Hall, Room 42');

INSERT INTO order_items (order_id, menu_item_id, quantity, unit_price, special_instructions)
VALUES (1, 1, 1, 25.00, 'Extra fish please');

INSERT INTO carts (student_id, vendor_id)
VALUES (2, 3);

INSERT INTO cart_items (cart_id, menu_item_id, quantity)
VALUES (1, 1, 2);

INSERT INTO vendor_ratings (student_id, vendor_id, rating, review)
VALUES (2, 3, 5, 'Great service and delicious food!');

INSERT INTO menu_item_ratings (student_id, menu_item_id, rating, review)
VALUES (2, 1, 4, 'The Waakye was really good but could use more protein.');

INSERT INTO order_ratings (student_id, order_id, rating, review)
VALUES (2, 1, 5, 'Fast delivery and food was still hot!');

INSERT INTO favorite_vendors (student_id, vendor_id)
VALUES (2, 3);

INSERT INTO favorite_menu_items (student_id, menu_item_id)
VALUES (2, 1);

INSERT INTO reports (reporter_id, reported_id, report_reason, report_status)
VALUES (2, 3, 'Food quality issues', 'pending');
