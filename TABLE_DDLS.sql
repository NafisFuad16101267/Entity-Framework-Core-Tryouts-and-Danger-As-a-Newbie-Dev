-- Create DDL for USER table

CREATE TABLE [USER](
    [user_id] INT IDENTITY(1,1), 
    [role] varchar(100),
    [address] varchar(140)

    CONSTRAINT PK_user PRIMARY KEY (user_id),
);


-- Create DDL for PRODUCT_TYPE table

CREATE TABLE PRODUCT_TYPE (
    product_type_id INT IDENTITY(1,1),
    type_name VARCHAR(100) NOT NULL,
    type_description VARCHAR(500) NULL,
    
    -- Audit Fields
    created_by INT NOT NULL,
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_by INT NOT NULL,
    modified_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT PK_product_type PRIMARY KEY (product_type_id),
    CONSTRAINT FK_product_type_created_by FOREIGN KEY (created_by) REFERENCES [USER](user_id),
    CONSTRAINT FK_product_type_modified_by FOREIGN KEY (modified_by) REFERENCES [USER](user_id)
);

-- Create DDL for PRODUCT table

CREATE TABLE product (
    product_id INT IDENTITY(1,1),
    product_type_id INT NOT NULL,
    manufacturer_id INT NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    model_number VARCHAR(100) NOT NULL,
    product_image VARCHAR(2048) NULL,
    
    -- Audit Fields
    created_by INT NOT NULL,
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_by INT NOT NULL,
    modified_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT PK_product PRIMARY KEY (product_id),
    CONSTRAINT FK_product_product_type FOREIGN KEY (product_type_id) REFERENCES product_type(product_type_id),
    CONSTRAINT FK_product_created_by FOREIGN KEY (created_by) REFERENCES [USER](user_id),
    CONSTRAINT FK_product_modified_by FOREIGN KEY (modified_by) REFERENCES [USER](user_id)
    -- Add the manufacturer foreign key once that table exists:
    -- CONSTRAINT FK_product_manufacturer FOREIGN KEY (manufacturer_id) REFERENCES manufacturer(manufacturer_id)
);