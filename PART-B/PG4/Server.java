import java.util.Scanner;
import java.net.*;

public class Server
{
	public static void main(String[] args)
	{

		DatagramSocket skt = null; 
		String ch;

		Scanner input = new Scanner(System.in); 
		try
		{

			skt = new DatagramSocket(6788); 
			byte[] buffer = new byte[1000];
			while(true)
			{

				DatagramPacket request = new DatagramPacket(buffer,buffer.length); 
				skt.receive(request);

				System.out.print("Enter the data: "); 
				ch = input.nextLine();

				byte[] sendMsg = (ch + " <- Server processed").getBytes(); 
				DatagramPacket reply = new DatagramPacket(sendMsg, sendMsg.length, request.getAddress(), request.getPort());
				skt.send(reply);
				skt.close();
			}
		}

		catch(Exception ex) {}

		input.close();
	}
}

