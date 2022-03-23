import java.io.*;
import java.net.*;


public class prac {

	public static void server() throws Exception {
		try {
			ServerSocket sersock = new ServerSocket(4000);
			System.out.println("Server Ready for connection");
			Socket sock = sersock.accept();
			System.out.println("Connection successful ready for chat");
			System.out.print("Server Input: ");

			InputStream istream = sock.getInputStream();
			BufferedReader fileRead = new BufferedReader(new InputStreamReader(istream));
			String fname = fileRead.readLine();
			BufferedReader contentRead = new BufferedReader(new FileReader(fname));
			OutputStream ostream = sock.getOutputStream();
			PrintWriter pwrite = new PrintWriter(ostream, true);
			String str;

			while ((str = contentRead.readLine()) != null)
				pwrite.println(str);
			sock.close();
			sersock.close();
			pwrite.close();
			fileRead.close();
			contentRead.close();
		} catch (Exception e)	{
			System.out.println("Error occureed");
		}
	}

	public static void  client() throws Exception {
		Socket sock = new Socket("127.0.0.1", 4000);
		BufferedReader keyRead = new BufferedReader(new InputStreamReader(System.in));
		String fname = keyRead.readLine();

		try {
			OutputStream ostream = sock.getOutputStream();
			PrintWriter pwrite = new PrintWriter(ostream, true);
			pwrite.println(fname);

			InputStream istream  = sock.getInputStream();
			BufferedReader socketRead  = new BufferedReader(new InputStreamReader(istream));
			String str;

			System.out.print("Client Output: ");
			while ((str = socketRead.readLine()) != null) 
				System.out.println(str);
			pwrite.close();
			socketRead.close();
			keyRead.close();
		} catch (Exception e) {
			System.out.println("Error");
		}
		sock.close();

	}


	public static void main(String[] args) {

		System.out.println("Server and Client Side running in parallel using multithreading");
			Thread t1 = new Thread() {
				@Override
				public void run() {
					try {
						server();	
					} catch (Exception e) {}
				}
			};


			Thread t2 = new Thread() {
				@Override
				public void run() {
					try {
						client();
					} catch (Exception e) {}
				}
			};

			t1.start();
			t2.start();

			try {
				t1.join();
				t2.join();
			} catch (Exception e) {}
	}
}
