-- Create the Users table
CREATE TABLE Users (
    user_id UUID PRIMARY KEY,  -- Unique identifier for users
    user_name VARCHAR(255) NOT NULL,  -- User's username
    user_birthday DATE, -- User's birthday
    user_phone INT NOT NULL,
    user_email VARCHAR(255) UNIQUE NOT NULL,  -- User's email (must be unique)
    user_password VARCHAR(255) NOT NULL  -- User's password
);

-- Create the Ingredients table 
CREATE TABLE Ingredients (
    ingredient_id UUID PRIMARY KEY,  -- Unique identifier for ingredients
    ingredient_name VARCHAR(255) NOT NULL,  -- Name of the ingredient
    ingredients_update DATE,
    expiration_id UUID NOT NULL,  -- Expiration date of the ingredient
    user_id UUID NOT NULL,  -- Foreign key to link ingredients to users
    ingredient_amount INT NOT NULL,
    ingredient_describe VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (expiration_id) REFERENCES ExpirationDate(expiration_id) 
);

-- Create the Recipes table 
CREATE TABLE Recipes (
    recipe_id UUID PRIMARY KEY,  -- Unique identifier for recipes
    recipe_name VARCHAR(255) NOT NULL,  -- Name of the recipe
    recipe_ingredients VARCHAR(255) NOT NULL,
    recipe_steps TEXT NOT NULL,  -- Step of the recipe
    user_id UUID,  -- Foreign key to link recipes to users
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create the Groups table 
CREATE TABLE Groups (
    group_id UUID PRIMARY KEY,  -- Unique identifier for groups
    group_name VARCHAR(255) NOT NULL,  -- Name of the group
    group_describe TEXT
);

-- Create the CalendarEvents table with UUID as EventID
CREATE TABLE CalendarEvents (
    event_id UUID PRIMARY KEY,  -- Unique identifier for calendar events
    event_name VARCHAR(255) NOT NULL,  -- Name of the event
    event_date DATE NOT NULL,  -- Date of the event
    event_describe TEXT,  -- Description of the event
    user_id UUID NOT NULL,  -- Foreign key to link events to users
    expiration_id UUID,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (expiration_id) REFERENCES ExpirationDate(expiration_id) 
);

-- Create the GroupCalendars table with UUID as GroupCalendarID
CREATE TABLE GroupCalendars (
    groupcalendar_id UUID PRIMARY KEY,  -- Unique identifier for group calendars
    groupcalender_name VARCHAR(255) NOT NULL,  -- Name of the group calendar
    groupcalender_describe TEXT,  -- Description of the group calendar
    group_id UUID,  -- Foreign key to link group calendars to groups
    event_id UUID,
    FOREIGN KEY (group_id) REFERENCES Groups(group_id),
    FOREIGN KEY (event_id) REFERENCES CalendarEvents(event_id)
);

-- Create the RecipeIngredients table to represent the relationship between recipes and ingredients
CREATE TABLE RecipeIngredients (
    recipe_id UUID,  -- Foreign key to link recipes
    ingredient_id UUID,  -- Foreign key to link ingredients
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
);

-- Create the UserGroups table to represent the relationship between users and groups
CREATE TABLE UserGroups (
    user_id UUID,  -- Foreign key to link users
    group_id UUID,  -- Foreign key to link groups
    PRIMARY KEY (user_id, group_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (group_id) REFERENCES Groups(group_id)
);

-- Create the ExpirationDate table
CREATE TABLE ExpirationDate (
    expiration_id INT AUTO_INCREMENT PRIMARY KEY,
    expiration_date DATE NOT NULL
);
