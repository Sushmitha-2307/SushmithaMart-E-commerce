package com.sushmithamart.service;

import com.sushmithamart.dao.UserDAO;
import com.sushmithamart.model.User;

public class UserService {

    private UserDAO userDAO = new UserDAO();

    public boolean registerUser(User user) {
        return userDAO.registerUser(user);
    }

    public User loginUser(String email, String password) {
        return userDAO.loginUser(email, password);
    }
}
