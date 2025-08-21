package com.pahanaedu.dao;

import org.junit.jupiter.api.Test;
import java.lang.reflect.Method;
import java.util.Arrays;
import static org.junit.jupiter.api.Assertions.*;

public class UserDAOImplTest {

    @Test
    public void daoImplClassExists() {
        assertNotNull(UserDAOImpl.class);
        assertFalse(UserDAOImpl.class.isInterface(), "UserDAOImpl should be a concrete class");
    }

    @Test
    public void daoImplImplementsInterface() {
        Class<?>[] interfaces = UserDAOImpl.class.getInterfaces();
        boolean implementsUserDAO = Arrays.stream(interfaces)
                .anyMatch(i -> i.equals(UserDAO.class));

        assertTrue(implementsUserDAO, "UserDAOImpl should implement UserDAO interface");
    }

    @Test
    public void daoImplCanBeInstantiated() {
        assertDoesNotThrow(() -> {
            UserDAOImpl dao = new UserDAOImpl();
            assertNotNull(dao);
        });
    }

    @Test
    public void daoImplHasCrudMethods() throws Exception {
        Class<?> cls = UserDAOImpl.class;
        Method[] methods = cls.getDeclaredMethods();

        boolean hasCrudMethods = Arrays.stream(methods)
                .anyMatch(m -> m.getName().contains("create") ||
                        m.getName().contains("save") ||
                        m.getName().contains("find") ||
                        m.getName().contains("get") ||
                        m.getName().contains("update") ||
                        m.getName().contains("delete"));

        assertTrue(hasCrudMethods, "UserDAOImpl should have CRUD methods");
    }
}
