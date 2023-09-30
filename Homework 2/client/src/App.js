import "./App.css";
import { useState } from "react";
import Axios from "axios";

function App() {
  const [username, setUsername] = useState("");
  const [birthday, setBirthday] = useState("");
  const [phone, setPhone] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [userList, setUserList] = useState([]);
  const [searchQuery, setSearchQuery] = useState(""); // State for the search query
  const [searchResults, setSearchResults] = useState([]); // State to store search results


  // Function to add a new user
  const addUser = () => {
    Axios.post("http://localhost:3001/createUser", {
      user_name: username,
      user_birthday: birthday,
      user_phone: phone,
      user_email: email,
      user_password: password,
    }).then(() => {
      getUsers(); // Refresh the user list
    });
  };

  // Function to get the list of users
  const getUsers = () => {
    Axios.get("http://localhost:3001/users").then((response) => {
      setUserList(response.data);
    });
  };

  // Function to format a date string
  const formatDate = (dateString) => {
    // Use a Date object to format the date
    const date = new Date(dateString);
    return date.toLocaleDateString(); // Format the date to the local date format
  };

  // Function to update a user's information
  const updateUser = (userId) => {
    const newUsername = prompt("Enter new username:");
    if (newUsername !== null) {
      Axios.put(`http://localhost:3001/updateUser/${userId}`, {
        new_username: newUsername,
      }).then(() => {
        getUsers(); // Refresh the user list
      });
    }
  };

  // Function to delete a user
  const deleteUser = (userId) => {
    Axios.delete(`http://localhost:3001/deleteUser/${userId}`).then(() => {
      getUsers(); // Refresh the user list
    });
  };

  // Function to search for users based on the search query
  const searchUsers = () => {
    Axios.get(`http://localhost:3001/searchUsers?search=${searchQuery}`).then(
      (response) => {
        setSearchResults(response.data);
      }
    );
  };
  


  return (
    <div className="App">
      <div className="information">
        <label>Username:</label>
        <input
          type="text"
          onChange={(event) => {
            setUsername(event.target.value);
          }}
        />
        <label>Birthday:</label>
        <input
          type="date"
          onChange={(event) => {
            setBirthday(event.target.value);
          }}
        />
        <label>Phone:</label>
        <input
          type="text"
          onChange={(event) => {
            setPhone(event.target.value);
          }}
        />
        <label>Email:</label>
        <input
          type="email"
          onChange={(event) => {
            setEmail(event.target.value);
          }}
        />
        <label>Password:</label>
        <input
          type="password"
          onChange={(event) => {
            setPassword(event.target.value);
          }}
        />
        <button onClick={addUser}>Add User</button>
      </div>
      <div className="users">
        <button onClick={getUsers}>Show Users</button>

        {userList.map((user, index) => {
          return (
            <div className="user" key={index}>
              <div>
                <h3>ID: {user.user_id}</h3>
                <h3>Username: {user.user_name}</h3>
                <h3>Birthday: {formatDate(user.user_birthday)}</h3>
                <h3>Phone: {user.user_phone}</h3>
                <h3>Email: {user.user_email}</h3>
                <button onClick={() => updateUser(user.user_id)}>Update</button>
                <button onClick={() => deleteUser(user.user_id)}>Delete</button>
              </div>
            </div>
          );
        })}
      </div>
      <div className="search">
        <label>Search Users:</label>
        <input
          type="text"
          onChange={(event) => {
            setSearchQuery(event.target.value);
          }}
        />
        <button onClick={searchUsers}>Search</button>
      </div>

      {/* Display search results */}
      <div className="search-results">
        {searchResults.map((result, index) => {
          return (
            <div className="search-result" key={index}>
              {/* <p>Username: {result.user_name}</p> */}
              <p>Ingredient: {result.ingredient_name}</p>
              <p>Expiration Date: {formatDate(result.expiration_date)}</p>
            </div>
          );
        })}
      </div>


    </div>
  );
}

export default App;
