INSERT INTO usersystem.Users (user_id, user_name, user_birthday, user_phone, user_email, user_password)
VALUES
    ('1b617c57-91de-4', 'user1', '1990-05-15', 12345, 'user1@example.com', 'password1'),
    ('2a826a98-76fe-4', 'user2', '1985-08-21', 98765, 'user2@example.com', 'password2'),
    ('3c039d14-f7cb-4', 'user3', '1995-03-03', 55555, 'user3@example.com', 'password3');

INSERT INTO usersystem.ExpirationDate (expiration_id, expiration_date)
VALUES
    (1, '2023-12-31'),
    (2, '2024-06-30'),
    (3, '2023-10-15');

INSERT INTO usersystem.Ingredients (ingredient_id, ingredient_name, ingredients_update, expiration_id, user_id, ingredient_amount, ingredient_describe)
VALUES
    ('1a4f8a1d-95db-4', 'Flour', '2023-09-17', 1, '1b617c57-91de-4', 500, 'All-purpose flour'),
    ('2d9e3b7c-5d12-4', 'Eggs', '2023-09-17', 2, '2a826a98-76fe-4', 12, 'Large eggs'),
    ('3e6c0f5a-3f8a-4', 'Milk', '2023-09-17', 3, '3c039d14-f7cb-4', 1.5, 'Whole milk');

/*SELECT * FROM usersystem.Ingredients;

SELECT * FROM usersystem.Ingredients WHERE ingredient_id = '1a4f8a1d-95db-4';

UPDATE usersystem.Ingredients
SET ingredient_amount = 15
WHERE ingredient_id = '2d9e3b7c-5d12-4';

DELETE FROM usersystem.Ingredients WHERE ingredient_id = '3e6c0f5a-3f8a-4';
*/

INSERT INTO usersystem.Recipes (recipe_id, recipe_name, recipe_ingredients, recipe_steps, user_id)
VALUES
    ('4f8b5d6a-2ef1-4', 'Pancakes', 'Flour, Eggs, Milk', '1. Mix ingredients. 2. Cook on a hot griddle.', '1b617c57-91de-4'),
    ('5c7d8e9f-3a4b-4', 'Scrambled Eggs', 'Eggs', '1. Whisk eggs. 2. Cook in a skillet.', '2a826a98-76fe-4'),
    ('6b3a4c2d-1f8e-4', 'Chocolate Cake', 'Flour, Eggs, Milk', '1. Mix ingredients. 2. Bake in the oven.', '3c039d14-f7cb-4');

INSERT INTO usersystem.Teams (group_id, group_name, group_describe)
VALUES
    ('7a3b8c5d-9e7f-4', 'Cooking Club', 'For cooking enthusiasts.'),
    ('8f2e1d9c-6b5a-4', 'Sports Team', 'For sports lovers.'),
    ('9c7b1d3e-4a8f-4', 'Study Group', 'For students.');

INSERT INTO usersystem.CalendarEvents (event_id, event_name, event_date, event_describe, user_id, expiration_id)
VALUES
    ('af7c8d9e-1b2c-4', 'Cooking Class', '2023-10-01', 'Learn to make pancakes.', '1b617c57-91de-4', 1),
    ('bf8e9c7d-2a3b-4', 'Soccer Match', '2023-09-25', 'Friendly soccer match.', '2a826a98-76fe-4', 2),
    ('cf9e1a2b-3c4d-4', 'Study Session', '2023-09-28', 'Group study for exams.', '3c039d14-f7cb-4', 3);

INSERT INTO usersystem.GroupCalendars (groupcalendar_id, groupcalender_name, groupcalender_describe, group_id, event_id)
VALUES
    ('1a2b3c4d-5e6f-4', 'Cooking Club Events', 'Events for Cooking Club', '7a3b8c5d-9e7f-4', 'af7c8d9e-1b2c-4'),
    ('2b3c4d5e-6f7a-4', 'Sports Team Events', 'Events for Sports Team', '8f2e1d9c-6b5a-4', 'bf8e9c7d-2a3b-4'),
    ('3c4d5e6f-7a8b-4', 'Study Group Events', 'Events for Study Group', '9c7b1d3e-4a8f-4', 'cf9e1a2b-3c4d-4');
