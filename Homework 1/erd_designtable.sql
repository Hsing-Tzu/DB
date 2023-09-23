-- Create the Users table
CREATE TABLE usersystem.Users (
    user_id VARCHAR(16) PRIMARY KEY,  -- Unique identifier for users
    user_name VARCHAR(255) NOT NULL,  -- User's username
    user_birthday DATE, -- User's birthday
    user_phone INT NOT NULL,
    user_email VARCHAR(255) UNIQUE NOT NULL,  -- User's email (must be unique)
    user_password VARCHAR(255) NOT NULL  -- User's password
);

-- Create the ExpirationDate table
CREATE TABLE usersystem.ExpirationDate (
    expiration_id INT AUTO_INCREMENT PRIMARY KEY,
    expiration_date DATE NOT NULL
);

-- Create the Ingredients table 
CREATE TABLE usersystem.Ingredients (
    ingredient_id VARCHAR(16) PRIMARY KEY,  -- Unique identifier for ingredients
    ingredient_name VARCHAR(255) NOT NULL,  -- Name of the ingredient
    ingredients_update DATE,
    expiration_id INT NOT NULL,  -- Expiration date of the ingredient
    user_id VARCHAR(16) NOT NULL,  -- Foreign key to link ingredients to users
    ingredient_amount INT NOT NULL,
    ingredient_describe VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (expiration_id) REFERENCES ExpirationDate(expiration_id) 
);

-- Create the Recipes table 
CREATE TABLE usersystem.Recipes (
    recipe_id VARCHAR(16) PRIMARY KEY,  -- Unique identifier for recipes
    recipe_name VARCHAR(255) NOT NULL,  -- Name of the recipe
    recipe_ingredients VARCHAR(255) NOT NULL,
    recipe_steps TEXT NOT NULL,  -- Step of the recipe
    user_id VARCHAR(16),  -- Foreign key to link recipes to users
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create the Teams table 
CREATE TABLE usersystem.Teams (
    group_id VARCHAR(16) PRIMARY KEY,  -- Unique identifier for Teams
    group_name VARCHAR(255) NOT NULL,  -- Name of the group
    group_describe TEXT
);

-- Create the CalendarEvents table with VARCHAR(16) as EventID
CREATE TABLE usersystem.CalendarEvents (
    event_id VARCHAR(16) PRIMARY KEY,  -- Unique identifier for calendar events
    event_name VARCHAR(255) NOT NULL,  -- Name of the event
    event_date DATE NOT NULL,  -- Date of the event
    event_describe TEXT,  -- Description of the event
    user_id VARCHAR(16) NOT NULL,  -- Foreign key to link events to users
    expiration_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (expiration_id) REFERENCES ExpirationDate(expiration_id) 
);

-- Create the GroupCalendars table with VARCHAR(16) as GroupCalendarID
CREATE TABLE usersystem.GroupCalendars (
    groupcalendar_id VARCHAR(16) PRIMARY KEY,  -- Unique identifier for group calendars
    groupcalender_name VARCHAR(255) NOT NULL,  -- Name of the group calendar
    groupcalender_describe TEXT,  -- Description of the group calendar
    group_id VARCHAR(16),  -- Foreign key to link group calendars to Teams
    event_id VARCHAR(16),
    FOREIGN KEY (group_id) REFERENCES Teams(group_id),
    FOREIGN KEY (event_id) REFERENCES CalendarEvents(event_id)
);

-- Create the RecipeIngredients table to represent the relationship between recipes and ingredients
CREATE TABLE usersystem.RecipeIngredients (
    recipe_id VARCHAR(16),  -- Foreign key to link recipes
    ingredient_id VARCHAR(16),  -- Foreign key to link ingredients
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
);

-- Create the UserTeams table to represent the relationship between users and Teams
CREATE TABLE usersystem.UserTeams (
    user_id VARCHAR(16),  -- Foreign key to link users
    group_id VARCHAR(16),  -- Foreign key to link Teams
    PRIMARY KEY (user_id, group_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (group_id) REFERENCES Teams(group_id)
);


