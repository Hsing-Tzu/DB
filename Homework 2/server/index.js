const express = require("express");
const app = express();
const mysql = require("mysql");
const cors = require("cors");
const { v4: uuidv4 } = require("uuid");

app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  user: "root",
  host: "localhost",
  password: "mysqlhw",
  database: "usersystem",
});

app.post("/createUser", (req, res) => {
  const username = req.body.user_name;
  const birthday = req.body.user_birthday;
  const phone = req.body.user_phone;
  const email = req.body.user_email;
  const password = req.body.user_password;

  const fullUUID = uuidv4();
  const userid = fullUUID.slice(0, 16);

  db.query(
    "INSERT INTO usersystem.users (user_id, user_name, user_birthday, user_phone, user_email, user_password) VALUES (?,?,?,?,?,?)",
    [userid, username, birthday, phone, email, password],
    (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).send("Error creating user");
      } else {
        console.log("User Created with ID: " + userid);
        res.status(200).send("User created successfully");
      }
    }
  );
});

app.get("/users", (req, res) => {
  db.query("SELECT * FROM usersystem.users", (err, result) => {
    if (err) {
      console.log(err);
      res.status(500).send("Error fetching users");
    } else {
      res.send(result);
    }
  });
});

app.put("/updateUser/:id", (req, res) => {
  const id = req.params.id;
  const newUsername = req.body.new_username;
  db.query(
    "UPDATE usersystem.users SET user_name = ? WHERE user_id = ?",
    [newUsername, id],
    (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).send("Error updating user");
      } else {
        res.send(result);
      }
    }
  );
});

app.delete("/deleteUser/:id", (req, res) => {
  const id = req.params.id;
  db.query(
    "DELETE FROM usersystem.users WHERE user_id = ?",
    id,
    (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).send("Error deleting user");
      } else {
        res.send(result);
      }
    }
  );
});

app.get("/searchUsers", (req, res) => {
    const searchQuery = req.query.search || "";
  
    const sqlQuery = `
      SELECT usersystem.users.user_name, usersystem.ingredients.ingredient_name, usersystem.expirationdate.expiration_date
      FROM usersystem.users
      INNER JOIN usersystem.ingredients ON usersystem.users.user_id = usersystem.ingredients.user_id
      INNER JOIN usersystem.expirationdate ON usersystem.ingredients.expiration_id = usersystem.expirationdate.expiration_id
      WHERE usersystem.users.user_name LIKE ?
      OR usersystem.ingredients.ingredient_name LIKE ?
      OR usersystem.expirationdate.expiration_date LIKE ?
    `;
  
    db.query(
      sqlQuery,
      [`%${searchQuery}%`, `%${searchQuery}%`, `%${searchQuery}%`],
      (err, result) => {
        if (err) {
          console.log(err);
          res.status(500).send("Error fetching search results");
        } else {
          res.send(result);
        }
      }
    );
  });

  

app.listen(3001, () => {
  console.log("Your server is running on port 3001");
});
