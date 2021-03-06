import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.ErrorNode;
import org.antlr.v4.runtime.tree.TerminalNode;

public class DOTPrettyPrintListener extends DOTBaseListener{

    private int depth, lastPosition;
    DOTPrettyPrintListener() {
        System.out.println("\nPretty-printed code:\n");
        depth = 0;
        lastPosition = 0;
    }

    public void printDepth() {
        for(int i = 0; i < depth; i++)
            System.out.print(" ");
    }

    @Override
    public void enterGraph(DOTParser.GraphContext ctx) {
        for(int i = 0; i < 3; i++) {
            if(ctx.children.get(i).getClass().toString().equals("class DOTParser$IdContext"))
                System.out.print(ctx.children.get(i).getChild(0).toString() + " ");
            else if(i == 2)
                System.out.print("{");
            else
                System.out.print(ctx.children.get(i).toString() + " ");
        }
        System.out.println();
        depth += 4;
    }

    @Override
    public void exitGraph(DOTParser.GraphContext ctx) {
        depth -= 4;
        printDepth();
        System.out.println("}");
        lastPosition++;
    }

    @Override
    public void enterStmt_list(DOTParser.Stmt_listContext ctx) {
    }

    @Override
    public void exitStmt_list(DOTParser.Stmt_listContext ctx) {
    }

    @Override
    public void enterStmt(DOTParser.StmtContext ctx) {
        int start = ctx.getStart().getCharPositionInLine();
        int stop = ctx.getStop().getCharPositionInLine();
        String source = ctx.getStart().getTokenSource().getInputStream().toString();
        String stmt = ctx.getStart().getTokenSource().getInputStream().toString().substring(start, stop);



        if(stmt.contains("subgraph") || stmt.contains("SUBGRAPH"))
            return;

        if(stmt.contains("["))
            stmt = stmt.substring(0, stmt.indexOf("["));

        stmt = stmt.replaceAll("\s*=\s*", " = ");

        stmt = stmt.replaceAll("\s*->\s*", " -> ");


        printDepth();

        System.out.print(stmt);
        lastPosition = stop;

    }

    @Override
    public void exitStmt(DOTParser.StmtContext ctx) {
        int start = ctx.getStart().getCharPositionInLine();
        int stop = ctx.getStop().getCharPositionInLine();
        String source = ctx.getStart().getTokenSource().getInputStream().toString();
        String stmt = ctx.getStart().getTokenSource().getInputStream().toString().substring(start, stop);


        if(stmt.toLowerCase().contains("subgraph"))
            return;

//        System.out.println();

        for(int i = lastPosition; i < ctx.getStart().getTokenSource().getInputStream().size(); i++) {
            lastPosition = i;
            char ch = ctx.getStart().getTokenSource().getInputStream().toString().charAt(i);
            boolean validIDChar = (ch >= 65 && ch <= 90) || (ch >= 97 && ch <= 122) || (ch >= 48 && ch <= 57);

            if (ch == ';') {
                System.out.println(ctx.getStart().getTokenSource().getInputStream().toString().charAt(i));
                return;
            }
            else if (validIDChar){
                System.out.print(ctx.getStart().getTokenSource().getInputStream().toString().charAt(i));
            }
            else
                return;
        }
    }

    @Override
    public void enterAttr_stmt(DOTParser.Attr_stmtContext ctx) {
        
    }

    @Override
    public void exitAttr_stmt(DOTParser.Attr_stmtContext ctx) {
        
    }

    @Override
    public void enterAttr_list(DOTParser.Attr_listContext ctx) {
        
    }

    @Override
    public void exitAttr_list(DOTParser.Attr_listContext ctx) {
        
    }

    @Override
    public void enterA_list(DOTParser.A_listContext ctx) {
        int start = ctx.getStart().getCharPositionInLine();
        int stop = ctx.getStop().getCharPositionInLine();
        String stmt = ctx.getStart().getTokenSource().getInputStream().toString().substring(start - 1, stop);

        System.out.print(stmt);
        lastPosition = stop;
    }

    @Override
    public void exitA_list(DOTParser.A_listContext ctx) {
        int start = lastPosition;
        String stmt = ctx.getStart().getTokenSource().getInputStream().toString().substring(start);
        int findSemiColon = stmt.indexOf("]") + 2;
        stmt = stmt.substring(0, findSemiColon);

        System.out.println(stmt);
        lastPosition = start + findSemiColon - 2;
    }

    @Override
    public void enterEdge_stmt(DOTParser.Edge_stmtContext ctx) {
        
    }

    @Override
    public void exitEdge_stmt(DOTParser.Edge_stmtContext ctx) {
        
    }

    @Override
    public void enterEdgeRHS(DOTParser.EdgeRHSContext ctx) {
        
    }

    @Override
    public void exitEdgeRHS(DOTParser.EdgeRHSContext ctx) {
        
    }

    @Override
    public void enterEdgeop(DOTParser.EdgeopContext ctx) {
        
    }

    @Override
    public void exitEdgeop(DOTParser.EdgeopContext ctx) {
        
    }

    @Override
    public void enterNode_stmt(DOTParser.Node_stmtContext ctx) {
        
    }

    @Override
    public void exitNode_stmt(DOTParser.Node_stmtContext ctx) {
        
    }

    @Override
    public void enterNode_id(DOTParser.Node_idContext ctx) {
        
    }

    @Override
    public void exitNode_id(DOTParser.Node_idContext ctx) {
        
    }

    @Override
    public void enterPort(DOTParser.PortContext ctx) {
        
    }

    @Override
    public void exitPort(DOTParser.PortContext ctx) {
        
    }

    @Override
    public void enterSubgraph(DOTParser.SubgraphContext ctx) {
        printDepth();
        for(int i = 0; i < 3; i++) {
            if(ctx.children.get(i).getClass().toString().equals("class DOTParser$IdContext"))
                System.out.print(ctx.children.get(i).getChild(0).toString() + " ");
            else if(i == 2)
                System.out.print("{");
            else
                System.out.print(ctx.children.get(i).toString() + " ");
        }
        System.out.println();
        depth += 4;
    }

    @Override
    public void exitSubgraph(DOTParser.SubgraphContext ctx) {
        depth -= 4;
        printDepth();
        System.out.println("}");
        lastPosition++;
    }

    @Override
    public void enterId(DOTParser.IdContext ctx) {
        
    }

    @Override
    public void exitId(DOTParser.IdContext ctx) {
        
    }

    @Override
    public void enterEveryRule(ParserRuleContext ctx) {
        
    }

    @Override
    public void exitEveryRule(ParserRuleContext ctx) {
        
    }

    @Override
    public void visitTerminal(TerminalNode node) {
    }

    @Override
    public void visitErrorNode(ErrorNode node) {
    }
}
