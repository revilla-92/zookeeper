package es.upm.dit.cnvr.pfinal;

public class Logger {
	// Modo debug
	private static boolean debug = false;
	
	public static void debug(String msg) {
		if (debug) {
			System.out.println("=============================================================");
			System.out.println(msg);
			System.out.println("=============================================================");
		}
	}
}
