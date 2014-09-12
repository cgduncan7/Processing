class LSystem
{
  char[] variables;
  char[] constants;
  Rule[] rules;
  String sequence, newSequence;
  int n, iterations;
  
  public LSystem(char[] variables, char[] constants, String start, Rule[] rules, int iterations)
  {
    this.iterations = iterations;
    n = 1;
    sequence = start;
    this.variables = variables;
    this.constants = constants;
    this.rules = rules;
    
    while (n <= iterations)
    {
      //print("Iteration " + n + "/" + iterations + ":\n");
      newSequence = "";
      for (int i = 0; i < sequence.length(); i++)
      {
        char c = sequence.charAt(i);
        if (new String(constants).indexOf(c) == -1)
          newSequence += checkRules(sequence.charAt(i));
        else
          newSequence += c;
      }
      n++;
      sequence = newSequence;
      //print("\tResult: " + sequence + "\n");
    }
    
    print("n = " + iterations + " : " + sequence + "\n");
    
  }
  
  String checkRules(char c)
  {
    //print("\tChecking rules for char " + c + "\n");
    for (Rule rule : rules)
    {
      if (rule.predecessor == c)
      {
        //print("\t\tReplacing " + c + " with " + rule.successor + "\n");
        return rule.successor;
      }
    }
    return "" + c;
  }
}

class Rule
{
  char predecessor;
  String successor;
  
  public Rule(char predecessor, String successor)
  {
    this.predecessor = predecessor;
    this.successor = successor;
  }
}

