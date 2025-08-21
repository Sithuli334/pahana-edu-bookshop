-- Sample Data for Pahana Edu Billing System Dashboard
-- Run this script after setting up the basic database structure

USE pahana_edu_db;

-- NOTE: Removed destructive DELETE statements so this script will not wipe existing data.
-- Insert test admin user (password: admin123)
-- The password hash is for 'admin123' using simple SHA-256
-- Insert admin user (idempotent)
INSERT INTO users (email, password, name) VALUES
('admin@pahanaedu.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'System Administrator')
ON DUPLICATE KEY UPDATE email = email;

-- Insert sample customers (idempotent)
INSERT INTO customers (name, email, phone, address, accountNumber, customerType, telephoneNumber, unitsConsumed) VALUES
('ABC Corporation', 'contact@abc.com', '011-2345678', '123 Business Street, Colombo 01', 'ACC001', 'COMMERCIAL', '011-2345678', 1250.50),
('John Doe', 'john.doe@email.com', '077-1234567', '456 Residential Lane, Colombo 03', 'ACC002', 'RESIDENTIAL', '011-3456789', 850.25),
('XYZ Industries', 'info@xyz.com', '011-7654321', '789 Industrial Zone, Colombo 15', 'ACC003', 'INDUSTRIAL', '011-7654321', 2150.75),
('Smith Family', 'smith@family.com', '077-9876543', '321 Family Avenue, Colombo 05', 'ACC004', 'RESIDENTIAL', '011-5432109', 720.00),
('Tech Solutions Ltd', 'info@techsolutions.com', '011-1111222', '555 Tech Park, Colombo 07', 'ACC005', 'COMMERCIAL', '011-1111222', 1800.75),
('Green Manufacturing', 'contact@green.com', '011-3333444', '777 Green Zone, Colombo 14', 'ACC006', 'INDUSTRIAL', '011-3333444', 3200.50)
ON DUPLICATE KEY UPDATE accountNumber = accountNumber;

-- Insert sample items (idempotent)
INSERT INTO items (name, code, description, price, unit, stockQuantity) VALUES
('Electricity - Residential', 'ELEC-RES', 'Residential electricity billing per unit', 25.50, 'kWh', 999999),
('Electricity - Commercial', 'ELEC-COM', 'Commercial electricity billing per unit', 32.75, 'kWh', 999999),
('Electricity - Industrial', 'ELEC-IND', 'Industrial electricity billing per unit', 28.90, 'kWh', 999999),
('Water Supply', 'WATER-001', 'Municipal water supply per cubic meter', 45.00, 'm³', 999999),
('Service Charge', 'SVC-001', 'Monthly service and maintenance charge', 150.00, 'UNIT', 999999),
('Connection Fee', 'CONN-001', 'New connection setup fee', 500.00, 'UNIT', 999999)
ON DUPLICATE KEY UPDATE code = code;

-- Insert sample invoices (idempotent)
INSERT INTO invoices (invoiceNumber, customer_id, invoiceDate, dueDate, subtotal, taxAmount, discountAmount, totalAmount, paymentStatus, notes, paymentTerms) VALUES
('INV-2025-001', 1, '2025-08-01', '2025-08-31', 1000.00, 150.00, 50.00, 1100.00, 'PAID', 'Monthly electricity bill', 'Net 30'),
('INV-2025-002', 2, '2025-08-02', '2025-09-01', 500.00, 75.00, 0.00, 575.00, 'PAID', 'Residential electricity', 'Net 30'),
('INV-2025-003', 3, '2025-08-03', '2025-09-02', 2000.00, 300.00, 100.00, 2200.00, 'PENDING', 'Industrial electricity bill', 'Net 30'),
('INV-2025-004', 4, '2025-08-10', '2025-09-09', 300.00, 45.00, 0.00, 345.00, 'PAID', 'Family electricity bill', 'Net 30'),
('INV-2025-005', 5, '2025-08-12', '2025-09-11', 1500.00, 225.00, 75.00, 1650.00, 'PENDING', 'Commercial electricity', 'Net 30'),
('INV-2025-006', 6, '2025-08-15', '2025-09-14', 2500.00, 375.00, 125.00, 2750.00, 'PENDING', 'Industrial electricity', 'Net 30'),
('INV-2025-007', 1, '2025-07-15', '2025-08-14', 950.00, 142.50, 0.00, 1092.50, 'PAID', 'July electricity bill', 'Net 30'),
('INV-2025-008', 2, '2025-07-20', '2025-08-19', 480.00, 72.00, 20.00, 532.00, 'PAID', 'July residential bill', 'Net 30'),
('INV-2025-009', 3, '2025-06-25', '2025-07-24', 1800.00, 270.00, 90.00, 1980.00, 'OVERDUE', 'June industrial bill', 'Net 30'),
('INV-2025-010', 4, '2025-08-16', '2025-09-15', 275.00, 41.25, 0.00, 316.25, 'PENDING', 'August electricity', 'Net 30')
ON DUPLICATE KEY UPDATE invoiceNumber = invoiceNumber;

-- Insert sample invoice items using joins and NOT EXISTS to avoid duplicates or FK issues
-- Invoice 1 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 30.50, 32.75, 0.00, 999.38, 'Commercial electricity usage'
FROM invoices i
JOIN items it ON it.code = 'ELEC-COM'
WHERE i.invoiceNumber = 'INV-2025-001'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 999.38 AND ii.description = 'Commercial electricity usage'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 150.00, 149.38, 0.62, 'Service charge with discount'
FROM invoices i
JOIN items it ON it.code = 'SVC-001'
WHERE i.invoiceNumber = 'INV-2025-001'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 0.62 AND ii.description = 'Service charge with discount'
  );

-- Invoice 2 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 20.00, 25.50, 0.00, 510.00, 'Residential electricity usage'
FROM invoices i
JOIN items it ON it.code = 'ELEC-RES'
WHERE i.invoiceNumber = 'INV-2025-002'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 510.00 AND ii.description = 'Residential electricity usage'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 150.00, 85.00, 65.00, 'Partial service charge'
FROM invoices i
JOIN items it ON it.code = 'SVC-001'
WHERE i.invoiceNumber = 'INV-2025-002'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 65.00 AND ii.description = 'Partial service charge'
  );

-- Invoice 3 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 65.00, 28.90, 0.00, 1878.50, 'Industrial electricity usage'
FROM invoices i
JOIN items it ON it.code = 'ELEC-IND'
WHERE i.invoiceNumber = 'INV-2025-003'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 1878.50 AND ii.description = 'Industrial electricity usage'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 5.50, 45.00, 0.00, 247.50, 'Water supply'
FROM invoices i
JOIN items it ON it.code = 'WATER-001'
WHERE i.invoiceNumber = 'INV-2025-003'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 247.50 AND ii.description = 'Water supply'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 150.00, 76.00, 74.00, 'Service charge with discount'
FROM invoices i
JOIN items it ON it.code = 'SVC-001'
WHERE i.invoiceNumber = 'INV-2025-003'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 74.00 AND ii.description = 'Service charge with discount'
  );

-- Invoice 4 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 12.00, 25.50, 0.00, 306.00, 'Residential electricity usage'
FROM invoices i
JOIN items it ON it.code = 'ELEC-RES'
WHERE i.invoiceNumber = 'INV-2025-004'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 306.00 AND ii.description = 'Residential electricity usage'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 150.00, 111.00, 39.00, 'Partial service charge'
FROM invoices i
JOIN items it ON it.code = 'SVC-001'
WHERE i.invoiceNumber = 'INV-2025-004'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 39.00 AND ii.description = 'Partial service charge'
  );

-- Invoice 5 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 45.00, 32.75, 0.00, 1473.75, 'Commercial electricity usage'
FROM invoices i
JOIN items it ON it.code = 'ELEC-COM'
WHERE i.invoiceNumber = 'INV-2025-005'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 1473.75 AND ii.description = 'Commercial electricity usage'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 3.50, 45.00, 0.00, 157.50, 'Water supply'
FROM invoices i
JOIN items it ON it.code = 'WATER-001'
WHERE i.invoiceNumber = 'INV-2025-005'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 157.50 AND ii.description = 'Water supply'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 150.00, 131.25, 18.75, 'Service charge with discount'
FROM invoices i
JOIN items it ON it.code = 'SVC-001'
WHERE i.invoiceNumber = 'INV-2025-005'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 18.75 AND ii.description = 'Service charge with discount'
  );

-- Invoice 6 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 80.00, 28.90, 0.00, 2312.00, 'Industrial electricity usage'
FROM invoices i
JOIN items it ON it.code = 'ELEC-IND'
WHERE i.invoiceNumber = 'INV-2025-006'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 2312.00 AND ii.description = 'Industrial electricity usage'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 8.00, 45.00, 0.00, 360.00, 'Water supply'
FROM invoices i
JOIN items it ON it.code = 'WATER-001'
WHERE i.invoiceNumber = 'INV-2025-006'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 360.00 AND ii.description = 'Water supply'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 150.00, 72.00, 78.00, 'Service charge with discount'
FROM invoices i
JOIN items it ON it.code = 'SVC-001'
WHERE i.invoiceNumber = 'INV-2025-006'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 78.00 AND ii.description = 'Service charge with discount'
  );

-- Invoice 7 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 29.00, 32.75, 0.00, 949.75, 'July commercial electricity'
FROM invoices i
JOIN items it ON it.code = 'ELEC-COM'
WHERE i.invoiceNumber = 'INV-2025-007'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 949.75 AND ii.description = 'July commercial electricity'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 150.00, 7.25, 142.75, 'Service charge'
FROM invoices i
JOIN items it ON it.code = 'SVC-001'
WHERE i.invoiceNumber = 'INV-2025-007'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 142.75 AND ii.description = 'Service charge'
  );

-- Invoice 8 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 18.50, 25.50, 0.00, 471.75, 'July residential electricity'
FROM invoices i
JOIN items it ON it.code = 'ELEC-RES'
WHERE i.invoiceNumber = 'INV-2025-008'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 471.75 AND ii.description = 'July residential electricity'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 150.00, 89.75, 60.25, 'Partial service charge'
FROM invoices i
JOIN items it ON it.code = 'SVC-001'
WHERE i.invoiceNumber = 'INV-2025-008'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 60.25 AND ii.description = 'Partial service charge'
  );

-- Invoice 9 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 60.00, 28.90, 0.00, 1734.00, 'June industrial electricity'
FROM invoices i
JOIN items it ON it.code = 'ELEC-IND'
WHERE i.invoiceNumber = 'INV-2025-009'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 1734.00 AND ii.description = 'June industrial electricity'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 6.00, 45.00, 0.00, 270.00, 'Water supply'
FROM invoices i
JOIN items it ON it.code = 'WATER-001'
WHERE i.invoiceNumber = 'INV-2025-009'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 270.00 AND ii.description = 'Water supply'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 150.00, 174.00, -24.00, 'Service charge credit'
FROM invoices i
JOIN items it ON it.code = 'SVC-001'
WHERE i.invoiceNumber = 'INV-2025-009'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = -24.00 AND ii.description = 'Service charge credit'
  );

-- Invoice 10 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 10.50, 25.50, 0.00, 267.75, 'August residential electricity'
FROM invoices i
JOIN items it ON it.code = 'ELEC-RES'
WHERE i.invoiceNumber = 'INV-2025-010'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 267.75 AND ii.description = 'August residential electricity'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 150.00, 101.50, 48.50, 'Partial service charge'
FROM invoices i
JOIN items it ON it.code = 'SVC-001'
WHERE i.invoiceNumber = 'INV-2025-010'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 48.50 AND ii.description = 'Partial service charge'
  );

-- Display summary
SELECT 'Sample data inserted successfully!' as Status;
SELECT COUNT(*) as UserCount FROM users;
SELECT COUNT(*) as CustomerCount FROM customers;
SELECT COUNT(*) as ItemCount FROM items;
SELECT COUNT(*) as InvoiceCount FROM invoices;
SELECT COUNT(*) as InvoiceItemCount FROM invoice_items;
SELECT SUM(totalAmount) as TotalRevenue FROM invoices;
SELECT 
    paymentStatus, 
    COUNT(*) as Count, 
    SUM(totalAmount) as Amount 
FROM invoices 
GROUP BY paymentStatus;
