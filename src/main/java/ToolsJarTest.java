import com.sun.tools.attach.VirtualMachine;


/**
 * Just a test to see if Travis CI can compile this class with a custom JDK installation.
 */
public class ToolsJarTest {

  public static void main(String[] args) {
    VirtualMachine vm = null;
    System.out.println(vm);
  }
}
