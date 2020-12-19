import org.junit.Assert;
import org.junit.Test;
import org.junit.jupiter.api.BeforeEach;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

public class MainTest {

    private final PrintStream standardOut = System.out;
    private final ByteArrayOutputStream outputStreamCaptor = new ByteArrayOutputStream();

    @BeforeEach
    public void setUp() {
        System.out.println("F");
        System.setOut(new PrintStream(outputStreamCaptor));
    }

    @Test
    public void main() {

        Main.run();
        Assert.assertEquals("Start recognizing a digraph\n" +
                "Start recognizing a cluster\n" +
                "Start recognizing a property\n" +
                "Finish recognizing a property\n" +
                "Start recognizing a subgraph\n" +
                "Start recognizing a cluster\n" +
                "Start recognizing an edge statement\n" +
                "Start recognizing a property\n" +
                "Finish recognizing a property\n" +
                "Finish recognizing an edge statement\n" +
                "Start recognizing an edge statement\n" +
                "Start recognizing a property\n" +
                "Finish recognizing a property\n" +
                "Finish recognizing an edge statement\n" +
                "Finish recognizing a cluster\n" +
                "Finish recognizing a subgraph\n" +
                "Start recognizing a subgraph\n" +
                "Start recognizing a cluster\n" +
                "Start recognizing an edge statement\n" +
                "Start recognizing a property\n" +
                "Finish recognizing a property\n" +
                "Start recognizing a property\n" +
                "Finish recognizing a property\n" +
                "Finish recognizing an edge statement\n" +
                "Start recognizing an edge statement\n" +
                "Start recognizing a property\n" +
                "Finish recognizing a property\n" +
                "Finish recognizing an edge statement\n" +
                "Finish recognizing a cluster\n" +
                "Finish recognizing a subgraph\n" +
                "Finish recognizing a cluster\n" +
                "Finish recognizing a digraph", outputStreamCaptor.toString()
                .trim());
    }
}