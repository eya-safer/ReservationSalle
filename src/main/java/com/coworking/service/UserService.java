package com.coworking.service;

import com.coworking.dao.UserDAO;
import com.coworking.model.User;
import com.coworking.util.PasswordUtil;

import java.util.List;

public class UserService {

    private final UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    public User register(String username, String password, String email, String phone) {
        if (userDAO.findByUsername(username) != null) {
            System.err.println(" Nom d'utilisateur déjà pris");
            return null;
        }

        if (userDAO.findByEmail(email) != null) {
            System.err.println(" Email déjà utilisé");
            return null;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(PasswordUtil.hashPassword(password));
        user.setEmail(email);
        user.setPhone(phone);
        user.setRole("USER");

        long id = userDAO.create(user);
        if (id > 0) {
            return user;
        }
        return null;
    }

    public User login(String username, String password) {
        User user = userDAO.findByUsername(username);

        if (user != null && PasswordUtil.verifyPassword(password, user.getPassword())) {
            return user;
        }

        return null;
    }

    public User authenticate(String username, String password) {
        return login(username, password);
    }

    public User createUser(User user) {
        if (userDAO.findByUsername(user.getUsername()) != null) {
            System.err.println(" Nom d'utilisateur déjà pris");
            return null;
        }

        if (userDAO.findByEmail(user.getEmail()) != null) {
            System.err.println(" Email déjà utilisé");
            return null;
        }

        long id = userDAO.create(user);
        if (id > 0) {
            user.setId(id);
            return user;
        }
        return null;
    }

    public User getUserById(long id) {
        return userDAO.findById(id);
    }

    public List<User> getAllUsers() {
        return userDAO.findAll();
    }

    public List<User> getUsersByRole(String role) {
        return userDAO.findByRole(role);
    }

    public boolean updateUser(User user) {
        return userDAO.update(user);
    }

    public boolean changePassword(long userId, String oldPassword, String newPassword) {
        User user = userDAO.findById(userId);

        if (user == null) {
            return false;
        }

        if (!PasswordUtil.verifyPassword(oldPassword, user.getPassword())) {
            System.err.println(" Ancien mot de passe incorrect");
            return false;
        }

        String hashedPassword = PasswordUtil.hashPassword(newPassword);
        return userDAO.updatePassword(userId, hashedPassword);
    }

    public boolean deleteUser(long id) {
        return userDAO.delete(id);
    }

    public long countUsers() {
        return userDAO.count();
    }
}
