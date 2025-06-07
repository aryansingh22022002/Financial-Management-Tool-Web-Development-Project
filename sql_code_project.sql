create database aakar;
use aakar;
#drop schema aakar;
CREATE TABLE user (
    email_id VARCHAR(255) COLLATE utf8mb4_bin PRIMARY KEY,
    password VARCHAR(255) COLLATE utf8mb4_bin NOT NULL,
    full_name VARCHAR(255) COLLATE utf8mb4_bin NOT NULL
);

CREATE TABLE category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_date DATE NOT NULL,
    email_id VARCHAR(255) COLLATE utf8mb4_bin,
    category_id INT,
    amount FLOAT NOT NULL,
    description text,
    FOREIGN KEY (email_id)
        REFERENCES user (email_id)
        ON DELETE CASCADE,
    FOREIGN KEY (category_id)
        REFERENCES category (category_id)
        ON DELETE CASCADE
);

CREATE TABLE monthly_budget (
    year_col CHAR(4),
    month_col CHAR(2),
    email_id VARCHAR(255) COLLATE utf8mb4_bin,
    budget FLOAT,
    PRIMARY KEY (year_col , month_col , email_id),
    FOREIGN KEY (email_id)
        REFERENCES user (email_id)
        ON DELETE CASCADE
);


update category set category_name="Accommodation" where category_id=5;
insert into category
values (1,"Food"),
(2,"Household or Ration"),
(3,"Miscellaneous"),
(4,"Shopping or Entertainment"),
(5,"Accommodation");

select * from user;
select * from category;
select *  from monthly_budget;
select * from transactions where email_id="aryan.singh@gmail.com";


# Inserting data into monthly_budget
-- Inserting monthly budget for 2023
INSERT INTO monthly_budget (year_col, month_col, email_id, budget) VALUES
('2023', '01', 'aayush.joshi@gmail.com', 25000), -- January: ₹25,000 (including rent ₹20,000)
('2023', '02', 'aayush.joshi@gmail.com', 24000), -- February: ₹24,000 (adjust for other expenses)
('2023', '03', 'aayush.joshi@gmail.com', 26000), -- March: ₹26,000
('2023', '04', 'aayush.joshi@gmail.com', 25000), -- April: ₹25,000
('2023', '05', 'aayush.joshi@gmail.com', 25000), -- May: ₹25,000
('2023', '06', 'aayush.joshi@gmail.com', 25000), -- June: ₹25,000
('2023', '07', 'aayush.joshi@gmail.com', 25000), -- July: ₹25,000
('2023', '08', 'aayush.joshi@gmail.com', 25000), -- August: ₹25,000
('2023', '09', 'aayush.joshi@gmail.com', 24000), -- September: ₹24,000
('2023', '10', 'aayush.joshi@gmail.com', 25000), -- October: ₹25,000
('2023', '11', 'aayush.joshi@gmail.com', 25000), -- November: ₹25,000
('2023', '12', 'aayush.joshi@gmail.com', 25000); -- December: ₹25,000

-- Inserting monthly budget for 2024
INSERT INTO monthly_budget (year_col, month_col, email_id, budget) VALUES
('2024', '01', 'aayush.joshi@gmail.com', 25000), -- January: ₹25,000
('2024', '02', 'aayush.joshi@gmail.com', 25000), -- February: ₹25,000
('2024', '03', 'aayush.joshi@gmail.com', 25000), -- March: ₹25,000
('2024', '04', 'aayush.joshi@gmail.com', 25000), -- April: ₹25,000
('2024', '05', 'aayush.joshi@gmail.com', 25000), -- May: ₹25,000
('2024', '06', 'aayush.joshi@gmail.com', 25000), -- June: ₹25,000
('2024', '07', 'aayush.joshi@gmail.com', 25000), -- July: ₹25,000
('2024', '08', 'aayush.joshi@gmail.com', 25000), -- August: ₹25,000
('2024', '09', 'aayush.joshi@gmail.com', 25000), -- September: ₹25,000
('2024', '10', 'aayush.joshi@gmail.com', 25000), -- October: ₹25,000
('2024', '11', 'aayush.joshi@gmail.com', 25000), -- November: ₹25,000
('2024', '12', 'aayush.joshi@gmail.com', 25000); -- December: ₹25,000

-- Inserting monthly budget for 2023
INSERT INTO monthly_budget (year_col, month_col, email_id, budget) VALUES
('2023', '01', 'aryan.singh@gmail.com', 23000), -- January: ₹23,000 (including rent ₹18,000)
('2023', '02', 'aryan.singh@gmail.com', 22000), -- February: ₹22,000
('2023', '03', 'aryan.singh@gmail.com', 24000), -- March: ₹24,000
('2023', '04', 'aryan.singh@gmail.com', 23000), -- April: ₹23,000
('2023', '05', 'aryan.singh@gmail.com', 23000), -- May: ₹23,000
('2023', '06', 'aryan.singh@gmail.com', 23000), -- June: ₹23,000
('2023', '07', 'aryan.singh@gmail.com', 23000), -- July: ₹23,000
('2023', '08', 'aryan.singh@gmail.com', 23000), -- August: ₹23,000
('2023', '09', 'aryan.singh@gmail.com', 22000), -- September: ₹22,000
('2023', '10', 'aryan.singh@gmail.com', 23000), -- October: ₹23,000
('2023', '11', 'aryan.singh@gmail.com', 23000), -- November: ₹23,000
('2023', '12', 'aryan.singh@gmail.com', 23000); -- December: ₹23,000

-- Inserting monthly budget for 2024
INSERT INTO monthly_budget (year_col, month_col, email_id, budget) VALUES
('2024', '01', 'aryan.singh@gmail.com', 23000), -- January: ₹23,000
('2024', '02', 'aryan.singh@gmail.com', 23000), -- February: ₹23,000
('2024', '03', 'aryan.singh@gmail.com', 23000), -- March: ₹23,000
('2024', '04', 'aryan.singh@gmail.com', 23000), -- April: ₹23,000
('2024', '05', 'aryan.singh@gmail.com', 23000), -- May: ₹23,000
('2024', '06', 'aryan.singh@gmail.com', 23000), -- June: ₹23,000
('2024', '07', 'aryan.singh@gmail.com', 23000), -- July: ₹23,000
('2024', '08', 'aryan.singh@gmail.com', 23000), -- August: ₹23,000
('2024', '09', 'aryan.singh@gmail.com', 23000), -- September: ₹23,000
('2024', '10', 'aryan.singh@gmail.com', 23000), -- October: ₹23,000
('2024', '11', 'aryan.singh@gmail.com', 23000), -- November: ₹23,000
('2024', '12', 'aryan.singh@gmail.com', 23000); -- December: ₹23,000

-- Inserting monthly budget for 2023
INSERT INTO monthly_budget (year_col, month_col, email_id, budget) VALUES
('2023', '01', 'kartikeya.sinha@gmail.com', 25000), -- January: ₹25,000 (including rent ₹20,000)
('2023', '02', 'kartikeya.sinha@gmail.com', 24000), -- February: ₹24,000
('2023', '03', 'kartikeya.sinha@gmail.com', 25000), -- March: ₹25,000
('2023', '04', 'kartikeya.sinha@gmail.com', 25000), -- April: ₹25,000
('2023', '05', 'kartikeya.sinha@gmail.com', 25000), -- May: ₹25,000
('2023', '06', 'kartikeya.sinha@gmail.com', 25000), -- June: ₹25,000
('2023', '07', 'kartikeya.sinha@gmail.com', 25000), -- July: ₹25,000
('2023', '08', 'kartikeya.sinha@gmail.com', 25000), -- August: ₹25,000
('2023', '09', 'kartikeya.sinha@gmail.com', 24000), -- September: ₹24,000
('2023', '10', 'kartikeya.sinha@gmail.com', 25000), -- October: ₹25,000
('2023', '11', 'kartikeya.sinha@gmail.com', 25000), -- November: ₹25,000
('2023', '12', 'kartikeya.sinha@gmail.com', 25000); -- December: ₹25,000

-- Inserting monthly budget for 2024
INSERT INTO monthly_budget (year_col, month_col, email_id, budget) VALUES
('2024', '01', 'kartikeya.sinha@gmail.com', 25000), -- January: ₹25,000
('2024', '02', 'kartikeya.sinha@gmail.com', 25000), -- February: ₹25,000
('2024', '03', 'kartikeya.sinha@gmail.com', 25000), -- March: ₹25,000
('2024', '04', 'kartikeya.sinha@gmail.com', 25000), -- April: ₹25,000
('2024', '05', 'kartikeya.sinha@gmail.com', 25000), -- May: ₹25,000
('2024', '06', 'kartikeya.sinha@gmail.com', 25000), -- June: ₹25,000
('2024', '07', 'kartikeya.sinha@gmail.com', 25000), -- July: ₹25,000
('2024', '08', 'kartikeya.sinha@gmail.com', 25000), -- August: ₹25,000
('2024', '09', 'kartikeya.sinha@gmail.com', 25000), -- September: ₹25,000
('2024', '10', 'kartikeya.sinha@gmail.com', 25000), -- October: ₹25,000
('2024', '11', 'kartikeya.sinha@gmail.com', 25000), -- November: ₹25,000
('2024', '12', 'kartikeya.sinha@gmail.com', 25000); -- December: ₹25,000


# Inserting Data into transactions
-- Inserting transactions for 2023
INSERT INTO transactions (transaction_date, email_id, category_id, amount, description) VALUES
('2023-01-01', 'aayush.joshi@gmail.com', 1, 5000, 'Grocery shopping for the month'), -- Food
('2023-01-05', 'aayush.joshi@gmail.com', 4, 2000, 'Movie night with friends'), -- Entertainment
('2023-01-10', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2023-02-02', 'aayush.joshi@gmail.com', 2, 3000, 'Household items purchase'), -- Household or Ration
('2023-02-15', 'aayush.joshi@gmail.com', 3, 1500, 'Miscellaneous shopping'), -- Miscellaneous
('2023-03-10', 'aayush.joshi@gmail.com', 4, 3500, 'Shopping for new clothes'), -- Shopping or Entertainment
('2023-03-20', 'aayush.joshi@gmail.com', 1, 4500, 'Grocery shopping'), -- Food
('2023-04-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2023-04-05', 'aayush.joshi@gmail.com', 2, 4000, 'Household items purchase'), -- Household or Ration
('2023-05-05', 'aayush.joshi@gmail.com', 1, 5500, 'Grocery shopping for the month'), -- Food
('2023-05-10', 'aayush.joshi@gmail.com', 4, 3000, 'Entertainment expenses (movie, etc.)'), -- Entertainment
('2023-06-05', 'aayush.joshi@gmail.com', 1, 6000, 'Grocery shopping'), -- Food
('2023-07-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2023-07-10', 'aayush.joshi@gmail.com', 4, 2500, 'Shopping for personal items'), -- Entertainment
('2023-08-15', 'aayush.joshi@gmail.com', 2, 3500, 'Household and ration purchase'), -- Household or Ration
('2023-08-20', 'aayush.joshi@gmail.com', 3, 1200, 'Miscellaneous purchase'), -- Miscellaneous
('2023-09-01', 'aayush.joshi@gmail.com', 1, 4000, 'Grocery shopping'), -- Food
('2023-09-15', 'aayush.joshi@gmail.com', 4, 2500, 'Dining out with friends'), -- Entertainment
('2023-10-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2023-10-10', 'aayush.joshi@gmail.com', 3, 1500, 'Miscellaneous shopping'), -- Miscellaneous
('2023-11-10', 'aayush.joshi@gmail.com', 1, 5000, 'Grocery shopping for the month'), -- Food
('2023-11-15', 'aayush.joshi@gmail.com', 4, 2800, 'Entertainment (concert, etc.)'), -- Entertainment
('2023-12-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'); -- 

INSERT INTO transactions (transaction_date, email_id, category_id, amount, description) VALUES
('2024-01-05', 'aayush.joshi@gmail.com', 1, 5000, 'Grocery shopping'), -- Food
('2024-01-10', 'aayush.joshi@gmail.com', 4, 2000, 'Entertainment (movie night)'), -- Entertainment
('2024-02-02', 'aayush.joshi@gmail.com', 2, 3500, 'Household items purchase'), -- Household
('2024-02-15', 'aayush.joshi@gmail.com', 3, 1200, 'Miscellaneous shopping'), -- Miscellaneous
('2024-03-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2024-03-05', 'aayush.joshi@gmail.com', 4, 2500, 'Entertainment and shopping'), -- Entertainment
('2024-04-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2024-04-15', 'aayush.joshi@gmail.com', 1, 6000, 'Grocery shopping for the month'),
('2024-05-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2024-05-10', 'aayush.joshi@gmail.com', 2, 4500, 'Household and ration items'), -- Household or Ration
('2024-05-20', 'aayush.joshi@gmail.com', 4, 3500, 'Shopping and entertainment expenses'), -- Entertainment
('2024-06-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2024-06-10', 'aayush.joshi@gmail.com', 1, 5000, 'Grocery shopping for the month'), -- Food
('2024-06-15', 'aayush.joshi@gmail.com', 3, 2000, 'Miscellaneous shopping'), -- Miscellaneous
('2024-07-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2024-07-05', 'aayush.joshi@gmail.com', 1, 5500, 'Grocery shopping'), -- Food
('2024-07-20', 'aayush.joshi@gmail.com', 4, 3000, 'Movie tickets and snacks'), -- Entertainment
('2024-08-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2024-08-10', 'aayush.joshi@gmail.com', 2, 4000, 'Household purchases'), -- Household or Ration
('2024-08-15', 'aayush.joshi@gmail.com', 3, 1800, 'Miscellaneous'), -- Miscellaneous
('2024-09-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2024-09-05', 'aayush.joshi@gmail.com', 1, 6000, 'Grocery shopping'), -- Food
('2024-09-15', 'aayush.joshi@gmail.com', 4, 2500, 'Concert tickets'), -- Entertainment
('2024-10-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2024-10-10', 'aayush.joshi@gmail.com', 1, 5500, 'Monthly groceries'), -- Food
('2024-10-20', 'aayush.joshi@gmail.com', 2, 3500, 'Household and ration items'), -- Household or Ration
('2024-11-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2024-11-05', 'aayush.joshi@gmail.com', 4, 3000, 'Shopping at the mall'), -- Entertainment
('2024-12-01', 'aayush.joshi@gmail.com', 5, 20000, 'Rent for the month'), -- Accommodation
('2024-12-10', 'aayush.joshi@gmail.com', 3, 1200, 'Miscellaneous holiday shopping'), -- Miscellaneous
('2024-12-15', 'aayush.joshi@gmail.com', 1, 5000, 'Grocery shopping for December'); 

-- Inserting transactions for 2023
INSERT INTO transactions (transaction_date, email_id, category_id, amount, description) VALUES
('2023-01-05', 'aryan.singh@gmail.com', 1, 4500, 'Grocery shopping for January'), -- Food
('2023-01-10', 'aryan.singh@gmail.com', 4, 1800, 'Movie night with friends'), -- Entertainment
('2023-01-15', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2023-02-02', 'aryan.singh@gmail.com', 2, 3500, 'Household items purchase'), -- Household or Ration
('2023-02-12', 'aryan.singh@gmail.com', 3, 1500, 'Miscellaneous shopping'), -- Miscellaneous
('2023-03-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2023-03-10', 'aryan.singh@gmail.com', 4, 2500, 'Shopping and entertainment'), -- Entertainment
('2023-03-15', 'aryan.singh@gmail.com', 1, 5000, 'Grocery shopping for March'), -- Food
('2023-04-05', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2023-04-10', 'aryan.singh@gmail.com', 2, 4000, 'Household and ration items'), -- Household or Ration
('2023-04-20', 'aryan.singh@gmail.com', 3, 2000, 'Miscellaneous expenses'), -- Miscellaneous
('2023-05-01', 'aryan.singh@gmail.com', 1, 5500, 'Grocery shopping for May'), -- Food
('2023-05-10', 'aryan.singh@gmail.com', 4, 2200, 'Shopping and entertainment'), -- Entertainment
('2023-05-20', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2023-06-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2023-06-10', 'aryan.singh@gmail.com', 1, 6000, 'Grocery shopping for the month'), -- Food
('2023-06-20', 'aryan.singh@gmail.com', 3, 1800, 'Miscellaneous expenses'), -- Miscellaneous
('2023-07-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2023-07-10', 'aryan.singh@gmail.com', 2, 3500, 'Household items purchase'), -- Household or Ration
('2023-07-15', 'aryan.singh@gmail.com', 4, 2700, 'Entertainment expenses (cinema)'), -- Entertainment
('2023-08-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2023-08-05', 'aryan.singh@gmail.com', 1, 4500, 'Grocery shopping'), -- Food
('2023-08-15', 'aryan.singh@gmail.com', 3, 2000, 'Miscellaneous purchase'), -- Miscellaneous
('2023-09-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2023-09-10', 'aryan.singh@gmail.com', 1, 5500, 'Grocery shopping for September'), -- Food
('2023-09-20', 'aryan.singh@gmail.com', 4, 2500, 'Entertainment expenses'), -- Entertainment
('2023-10-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2023-10-05', 'aryan.singh@gmail.com', 2, 4000, 'Household items'), -- Household or Ration
('2023-10-15', 'aryan.singh@gmail.com', 1, 5000, 'Grocery shopping for the month'), -- Food
('2023-11-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2023-11-05', 'aryan.singh@gmail.com', 4, 3000, 'Entertainment (movie night)'), -- Entertainment
('2023-11-15', 'aryan.singh@gmail.com', 3, 2000, 'Miscellaneous spending'), -- Miscellaneous
('2023-12-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'); -- Accommodation

-- Continuing transactions for 2024
INSERT INTO transactions (transaction_date, email_id, category_id, amount, description) VALUES
('2024-01-05', 'aryan.singh@gmail.com', 1, 5000, 'Grocery shopping for January'), -- Food
('2024-01-10', 'aryan.singh@gmail.com', 4, 2200, 'Entertainment expenses'), -- Entertainment
('2024-01-15', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2024-02-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2024-02-05', 'aryan.singh@gmail.com', 1, 5500, 'Grocery shopping for February'), -- Food
('2024-02-15', 'aryan.singh@gmail.com', 3, 2500, 'Miscellaneous expenses'), -- Miscellaneous
('2024-03-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2024-03-10', 'aryan.singh@gmail.com', 2, 4000, 'Household purchase'), -- Household or Ration
('2024-03-20', 'aryan.singh@gmail.com', 1, 6000, 'Grocery shopping for March'), -- Food
('2024-04-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2024-04-05', 'aryan.singh@gmail.com', 4, 2200, 'Shopping and entertainment'), -- Entertainment
('2024-04-15', 'aryan.singh@gmail.com', 3, 1500, 'Miscellaneous items'), -- Miscellaneous
('2024-05-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2024-05-10', 'aryan.singh@gmail.com', 1, 4500, 'Grocery shopping for May'), -- Food
('2024-05-15', 'aryan.singh@gmail.com', 2, 3500, 'Household shopping'), -- Household or Ration
('2024-06-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2024-06-10', 'aryan.singh@gmail.com', 1, 5000, 'Grocery shopping for June'), -- Food
('2024-06-20', 'aryan.singh@gmail.com', 4, 2500, 'Entertainment (movies, snacks)'), -- Entertainment
('2024-07-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2024-07-05', 'aryan.singh@gmail.com', 1, 5500, 'Grocery shopping for July'), -- Food
('2024-07-15', 'aryan.singh@gmail.com', 3, 1800, 'Miscellaneous shopping'), -- Miscellaneous
('2024-08-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2024-08-05', 'aryan.singh@gmail.com', 2, 4000, 'Household items purchase'), -- Household or Ration
('2024-08-10', 'aryan.singh@gmail.com', 1, 6000, 'Grocery shopping for August'), -- Food
('2024-09-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2024-09-10', 'aryan.singh@gmail.com', 4, 2800, 'Shopping for entertainment'), -- Entertainment
('2024-09-15', 'aryan.singh@gmail.com', 1, 5500, 'Grocery shopping for September'), -- Food
('2024-10-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2024-10-05', 'aryan.singh@gmail.com', 3, 2200, 'Miscellaneous shopping'), -- Miscellaneous
('2024-10-15', 'aryan.singh@gmail.com', 1, 6000, 'Grocery shopping for October'), -- Food
('2024-11-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2024-11-05', 'aryan.singh@gmail.com', 4, 3200, 'Entertainment expenses'), -- Entertainment
('2024-11-15', 'aryan.singh@gmail.com', 2, 3500, 'Household items'), -- Household or Ration
('2024-12-01', 'aryan.singh@gmail.com', 5, 18000, 'Rent payment for the month'), -- Accommodation
('2024-12-05', 'aryan.singh@gmail.com', 1, 5000, 'Grocery shopping for December'), -- Food
('2024-12-10', 'aryan.singh@gmail.com', 3, 1700, 'Miscellaneous shopping'), -- Miscellaneous
('2024-12-15', 'aryan.singh@gmail.com', 4, 2800, 'Entertainment expenses for December'); -- Entertainment

-- Inserting transactions for 2023
-- Inserting transactions for 2023
INSERT INTO transactions (transaction_date, email_id, category_id, amount, description) VALUES
('2023-01-05', 'kartikeya.sinha@gmail.com', 1, 5500, 'Grocery shopping for January'), -- Food
('2023-01-10', 'kartikeya.sinha@gmail.com', 4, 2000, 'Cinema and snacks'), -- Entertainment
('2023-01-15', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2023-02-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2023-02-05', 'kartikeya.sinha@gmail.com', 2, 4000, 'Household goods purchase'), -- Household or Ration
('2023-02-15', 'kartikeya.sinha@gmail.com', 3, 1800, 'Miscellaneous expenses'), -- Miscellaneous
('2023-03-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2023-03-10', 'kartikeya.sinha@gmail.com', 1, 6000, 'Grocery shopping for March'), -- Food
('2023-03-15', 'kartikeya.sinha@gmail.com', 4, 2500, 'Entertainment (movie and dinner)'), -- Entertainment
('2023-04-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2023-04-10', 'kartikeya.sinha@gmail.com', 1, 5500, 'Grocery shopping for April'), -- Food
('2023-04-20', 'kartikeya.sinha@gmail.com', 3, 1600, 'Miscellaneous spending'), -- Miscellaneous
('2023-05-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2023-05-10', 'kartikeya.sinha@gmail.com', 2, 3500, 'Household shopping'), -- Household or Ration
('2023-05-15', 'kartikeya.sinha@gmail.com', 1, 6000, 'Grocery shopping for May'), -- Food
('2023-06-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2023-06-05', 'kartikeya.sinha@gmail.com', 4, 3000, 'Entertainment: shopping and dining'), -- Entertainment
('2023-06-15', 'kartikeya.sinha@gmail.com', 3, 2000, 'Miscellaneous expenses'), -- Miscellaneous
('2023-07-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2023-07-05', 'kartikeya.sinha@gmail.com', 1, 5500, 'Grocery shopping for July'), -- Food
('2023-07-15', 'kartikeya.sinha@gmail.com', 2, 4000, 'Household shopping'), -- Household or Ration
('2023-08-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2023-08-10', 'kartikeya.sinha@gmail.com', 1, 6000, 'Grocery shopping for August'), -- Food
('2023-08-15', 'kartikeya.sinha@gmail.com', 3, 1800, 'Miscellaneous purchase'), -- Miscellaneous
('2023-09-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2023-09-10', 'kartikeya.sinha@gmail.com', 4, 2500, 'Entertainment (movies, snacks)'), -- Entertainment
('2023-09-15', 'kartikeya.sinha@gmail.com', 1, 5500, 'Grocery shopping for September'), -- Food
('2023-10-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2023-10-05', 'kartikeya.sinha@gmail.com', 2, 4000, 'Household items'), -- Household or Ration
('2023-10-15', 'kartikeya.sinha@gmail.com', 1, 6000, 'Grocery shopping for October'), -- Food
('2023-11-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2023-11-05', 'kartikeya.sinha@gmail.com', 3, 1500, 'Miscellaneous expenses'), -- Miscellaneous
('2023-11-15', 'kartikeya.sinha@gmail.com', 4, 3200, 'Shopping and entertainment'), -- Entertainment
('2023-12-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2023-12-05', 'kartikeya.sinha@gmail.com', 1, 5000, 'Grocery shopping for December'), -- Food
('2023-12-10', 'kartikeya.sinha@gmail.com', 3, 1800, 'Miscellaneous holiday expenses'), -- Miscellaneous
('2023-12-15', 'kartikeya.sinha@gmail.com', 4, 2500, 'Christmas entertainment (shopping)'), -- Entertainment
('2023-12-20', 'kartikeya.sinha@gmail.com', 2, 4000, 'Household items for December'), -- Household or Ration
('2023-12-25', 'kartikeya.sinha@gmail.com', 1, 6000, 'Grocery shopping for Christmas meals'), -- Food
('2023-12-30', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'); -- Accommodation

-- Insert transactions for January 2024 to December 12, 2024
INSERT INTO transactions (transaction_date, email_id, category_id, amount, description) VALUES
('2024-01-05', 'kartikeya.sinha@gmail.com', 1, 5500, 'Grocery shopping for January'), -- Food
('2024-01-10', 'kartikeya.sinha@gmail.com', 4, 2500, 'New Year celebration entertainment'), -- Entertainment
('2024-01-15', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2024-01-20', 'kartikeya.sinha@gmail.com', 2, 4000, 'Household goods purchase for January'), -- Household or Ration
('2024-01-25', 'kartikeya.sinha@gmail.com', 3, 1500, 'Miscellaneous expenses for the month'), -- Miscellaneous
('2024-02-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2024-02-05', 'kartikeya.sinha@gmail.com', 1, 6000, 'Grocery shopping for February'), -- Food
('2024-02-10', 'kartikeya.sinha@gmail.com', 4, 2800, 'Entertainment (cinema, snacks)'), -- Entertainment
('2024-02-15', 'kartikeya.sinha@gmail.com', 2, 3500, 'Household goods purchase for February'), -- Household or Ration
('2024-02-20', 'kartikeya.sinha@gmail.com', 3, 1600, 'Miscellaneous expenses for February'), -- Miscellaneous
('2024-03-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2024-03-05', 'kartikeya.sinha@gmail.com', 1, 5500, 'Grocery shopping for March'), -- Food
('2024-03-10', 'kartikeya.sinha@gmail.com', 4, 3000, 'Entertainment (night out, shopping)'), -- Entertainment
('2024-03-15', 'kartikeya.sinha@gmail.com', 2, 4000, 'Household shopping for March'), -- Household or Ration
('2024-03-20', 'kartikeya.sinha@gmail.com', 3, 1800, 'Miscellaneous items purchase'), -- Miscellaneous
('2024-04-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2024-04-05', 'kartikeya.sinha@gmail.com', 1, 6000, 'Grocery shopping for April'), -- Food
('2024-04-10', 'kartikeya.sinha@gmail.com', 2, 3500, 'Household items purchase for April'), -- Household or Ration
('2024-04-15', 'kartikeya.sinha@gmail.com', 4, 2800, 'Shopping for entertainment'), -- Entertainment
('2024-04-20', 'kartikeya.sinha@gmail.com', 3, 1700, 'Miscellaneous spending'), -- Miscellaneous
('2024-05-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2024-05-05', 'kartikeya.sinha@gmail.com', 1, 5500, 'Grocery shopping for May'), -- Food
('2024-05-10', 'kartikeya.sinha@gmail.com', 4, 2900, 'Entertainment (movies, dining)'), -- Entertainment
('2024-05-15', 'kartikeya.sinha@gmail.com', 2, 4000, 'Household shopping for May'), -- Household or Ration
('2024-05-20', 'kartikeya.sinha@gmail.com', 3, 1600, 'Miscellaneous expenses for May'), -- Miscellaneous
('2024-06-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2024-06-05', 'kartikeya.sinha@gmail.com', 1, 6000, 'Grocery shopping for June'), -- Food
('2024-06-10', 'kartikeya.sinha@gmail.com', 4, 3000, 'Entertainment (shopping, night out)'), -- Entertainment
('2024-06-15', 'kartikeya.sinha@gmail.com', 2, 3500, 'Household goods purchase for June'), -- Household or Ration
('2024-06-20', 'kartikeya.sinha@gmail.com', 3, 1800, 'Miscellaneous purchases for June'), -- Miscellaneous
('2024-07-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2024-07-05', 'kartikeya.sinha@gmail.com', 1, 5500, 'Grocery shopping for July'), -- Food
('2024-07-10', 'kartikeya.sinha@gmail.com', 4, 2700, 'Entertainment (cinema, dinner)'), -- Entertainment
('2024-07-15', 'kartikeya.sinha@gmail.com', 2, 4000, 'Household shopping for July'), -- Household or Ration
('2024-07-20', 'kartikeya.sinha@gmail.com', 3, 1700, 'Miscellaneous spending for July'), -- Miscellaneous
('2024-08-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2024-08-05', 'kartikeya.sinha@gmail.com', 1, 6000, 'Grocery shopping for August'), -- Food
('2024-08-10', 'kartikeya.sinha@gmail.com', 4, 3200, 'Entertainment (shopping, theater)'), -- Entertainment
('2024-08-15', 'kartikeya.sinha@gmail.com', 2, 3500, 'Household items for August'), -- Household or Ration
('2024-08-20', 'kartikeya.sinha@gmail.com', 3, 1800, 'Miscellaneous purchases for August'), -- Miscellaneous
('2024-09-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2024-09-05', 'kartikeya.sinha@gmail.com', 1, 5500, 'Grocery shopping for September'), -- Food
('2024-09-10', 'kartikeya.sinha@gmail.com', 4, 3000, 'Entertainment (movies, snacks)'), -- Entertainment
('2024-09-15', 'kartikeya.sinha@gmail.com', 2, 4000, 'Household goods for September'), -- Household or Ration
('2024-09-20', 'kartikeya.sinha@gmail.com', 3, 1600, 'Miscellaneous expenses for September'), -- Miscellaneous
('2024-10-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2024-10-05', 'kartikeya.sinha@gmail.com', 1, 6000, 'Grocery shopping for October'), -- Food
('2024-10-10', 'kartikeya.sinha@gmail.com', 4, 2500, 'Entertainment (shopping, night out)'), -- Entertainment
('2024-10-15', 'kartikeya.sinha@gmail.com', 2, 3500, 'Household shopping for October'), -- Household or Ration
('2024-10-20', 'kartikeya.sinha@gmail.com', 3, 1700, 'Miscellaneous expenses for October'), -- Miscellaneous
('2024-11-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2024-11-05', 'kartikeya.sinha@gmail.com', 1, 5500, 'Grocery shopping for November'), -- Food
('2024-11-10', 'kartikeya.sinha@gmail.com', 4, 2800, 'Entertainment (movies, snacks)'), -- Entertainment
('2024-11-15', 'kartikeya.sinha@gmail.com', 2, 4000, 'Household items for November'), -- Household or Ration
('2024-11-20', 'kartikeya.sinha@gmail.com', 3, 1600, 'Miscellaneous shopping for November'), -- Miscellaneous
('2024-12-01', 'kartikeya.sinha@gmail.com', 5, 20000, 'Rent payment for the month'), -- Accommodation
('2024-12-05', 'kartikeya.sinha@gmail.com', 1, 6000, 'Grocery shopping for December'), -- Food
('2024-12-10', 'kartikeya.sinha@gmail.com', 4, 3000, 'Entertainment (shopping, dinner)'); -- Entertainment


SELECT CONCAT(month_col, '-', year_col) AS month_year, budget 
                    FROM monthly_budget 
                    WHERE email_id="aayush.joshi@gmail.com"
                    ORDER BY year_col, month_col;

SELECT trans.date_t, ROUND(SUM(trans.amount), 3) AS total_amount 
                FROM (
                    SELECT *, CONCAT(LPAD(MONTH(transaction_date), 2, '0'), '-', YEAR(transaction_date)) AS date_t 
                    FROM transactions WHERE email_id="aayush.joshi@gmail.com"
                ) trans 
                GROUP BY trans.date_t
                ORDER BY MIN(trans.transaction_date) ASC;
