import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;


public class CustomerDAOTest {
    private CustomerDAO customerDAO = new CustomerDAO();

    @Test
    public void testGenerateNextAccountNumber() {
        // Get the current last account in DB
        String lastAcc = customerDAO.getLastAccountNumber(); // e.g., PEAC01 or PEAC05
        String nextAcc = customerDAO.generateNextAccountNumber();

        // Calculate expected next number
        String expectedNext;
        if (lastAcc == null) {
            expectedNext = "PEAC01";
        } else {
            int lastNum = Integer.parseInt(lastAcc.substring(4));
            expectedNext = "PEAC" + String.format("%02d", lastNum + 1);
        }

        // Verify next account matches expectation
        assertEquals(expectedNext, nextAcc);
    }
}
