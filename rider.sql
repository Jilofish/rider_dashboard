CREATE TABLE OrderList (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    pickup_location VARCHAR(255),
    delivery_address VARCHAR(255),
    order_items TEXT,
    rider_id INT,
    status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',
    FOREIGN KEY (rider_id) REFERENCES Riders(rider_id)
);

CREATE TABLE OngoingOrders (
    order_id INT PRIMARY KEY,
    rider_id INT,
    FOREIGN KEY (order_id) REFERENCES OrderList(order_id),
    FOREIGN KEY (rider_id) REFERENCES Riders(rider_id)
);

CREATE TABLE Messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    message_content TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES Riders(rider_id),
    FOREIGN KEY (receiver_id) REFERENCES Customers(customer_id)
);

CREATE TABLE TemplateMessages (
    template_id INT AUTO_INCREMENT PRIMARY KEY,
    message_title VARCHAR(255),
    message_content TEXT
);

CREATE TABLE RiderAvailability (
    rider_id INT PRIMARY KEY,
    is_available BOOLEAN DEFAULT TRUE,
    workload INT DEFAULT 0
);

CREATE TABLE Riders (
    rider_id INT AUTO_INCREMENT PRIMARY KEY,
    rider_name VARCHAR(255),
    rider_phone VARCHAR(15),
    rider_email VARCHAR(255)
);

-- Inserting sample data into Riders table
INSERT INTO Riders (rider_name, rider_phone, rider_email) 
VALUES 
('John Doe', '+1234567890', 'john.doe@example.com'),
('Jane Smith', '+1987654321', 'jane.smith@example.com');

-- Inserting sample data into OrderList table
INSERT INTO OrderList (pickup_location, delivery_address, order_items, rider_id, status) 
VALUES 
('123 Main St, CityA', '456 Elm St, CityA', 'Item1, Item2, Item3', 1, 'pending'),
('789 Oak St, CityB', '321 Maple St, CityB', 'Item4, Item5', 2, 'pending');

-- Inserting sample data into OngoingOrders table
INSERT INTO OngoingOrders (order_id, rider_id) 
VALUES 
(1, 1),
(2, 2);

-- Inserting sample data into Messages table
INSERT INTO Messages (sender_id, receiver_id, message_content) 
VALUES 
(1, 2, 'Arrived at pickup location.'),
(1, 2, 'On the way to delivery location.'),
(2, 1, 'Waiting at pickup location.');

-- Inserting sample data into TemplateMessages table
INSERT INTO TemplateMessages (message_title, message_content) 
VALUES 
('Arrived at pickup location', 'Dear customer, I have arrived at the pickup location.'),
('On the way', 'Dear customer, your order is on the way.');

-- Inserting sample data into RiderAvailability table
INSERT INTO RiderAvailability (rider_id, is_available, workload) 
VALUES 
(1, TRUE, 2),
(2, FALSE, 1);
