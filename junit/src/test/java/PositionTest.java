/* 
 * The test cases belong to the default package because 
 * the class under test is in the default package.
 */

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class PositionTest {

    @Test
    public void testIsPointInRect() {
        example program = new example();
        assertTrue(program.isPointInRect(0, 0, 0, 0, 10, 10));
        assertTrue(program.isPointInRect(10, 10, 0, 0, 10, 10));
        assertTrue(program.isPointInRect(0, 10, 0, 0, 10, 10));
        assertTrue(program.isPointInRect(10, 0, 0, 0, 10, 10));
        assertFalse(program.isPointInRect(10, 11, 0, 0, 10, 10));
        assertFalse(program.isPointInRect(-1, 0, 0, 0, 10, 10));
        assertFalse(program.isPointInRect(0, -1, 0, 0, 10, 10));
        assertFalse(program.isPointInRect(11, 10, 0, 0, 10, 10));
        
    }

}
