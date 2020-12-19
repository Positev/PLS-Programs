import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.*;

import java.util.Scanner;
import java.io.IOException;

public class Main {

    public static void run(){


        StringBuilder dotCode = new StringBuilder();
/*
        Scanner stdin = new Scanner(System.in);

        while (stdin.hasNextLine()) {
            String line = stdin.nextLine();

            if (line.equals("\n")  || line.equals("")) {
                break;
            } else {
                dotCode.append(line);
            }
        }*/

        dotCode.append("digraph trees {rankdir=LR;subgraph t {0 -> \"1\" [label = \"A\"];0 -> \"2\" [label\n" +
                "= \"B\"];}SUBGRAPH u {Animal -> Cat [label = \"feline\", shape=\"record\"];Animal ->\n" +
                "Dog1 [label = \"canine\"];}}");

        //Invoke a lexer for lexical anaylasis
        DOTLexer lexer = new DOTLexer(new ANTLRInputStream(dotCode.toString()));

        //Prepare the list of tokens identified
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        //Pass the token list to the parser for syntax anaylasis
        DOTParser parser = new DOTParser(tokens);

        //Get the AST tree built for the input DOT code
        ParseTree tree = parser.graph();

        //Create a walker that can be used to traverse the tree (AST)
        ParseTreeWalker walker = new ParseTreeWalker();

        //for TaskII
        //Create a listener for pretty print
        DOTBaseListener baseListener = new DOTBaseListener();
        //Walk the tree by attaching the listener to the walker
        walker.walk(baseListener, tree);


        //Create a listener for pretty print
        DOTPrettyPrintListener prettyListener = new DOTPrettyPrintListener();
        //Walk the tree by attaching the listener to the walker
//         walker.walk(prettyListener, tree);
    }
    public static void main(String[] args) throws IOException {
        run();
    }
}
